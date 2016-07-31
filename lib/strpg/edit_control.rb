require 'strpg/dirs'
require 'strpg/task_manager'
require 'strpg/utils'
require 'strpg/template'
require 'erb'

module Strpg
  module EditControl
    include Strpg::Utils

    def do_writable_only_strict_file
      do_unwritable_all
      do_writable_files (TaskManager.file_striction_extracts Dirs::ALL_TASK_DIRS)
    end

    def do_writable_files file_paths
      change_files_writable file_paths, 'u+w'
    end

    def do_unwritable_files file_paths
      change_files_writable file_paths, 'u-w'
    end

    def do_writable_all
      change_files_writable Dirs::WRITABLE_DIRS, 'u+w'
    end

    def do_unwritable_all
      change_files_writable Dirs::WRITABLE_DIRS, 'u-w'
    end

    def change_files_writable file_paths, mode
      file_paths.each do |file_path|
        begin
          FileUtils.chmod(mode, file_path)
        rescue
          create_file file_path
        end
        (puts "writable #{file_path}") if mode == 'u+w' && caller[2][/`([^']*)'/, 1] != 'do_writable_all'
      end
    end

    def create_file file_path
      dir = get_dir file_path

      rescue_proc = -> do
        FileUtils.mkdir_p dir
        FileUtils.touch file_path
      end

      writable_exec(dir, rescue_proc) do 
        case file_path.split('/')[1]
        when 'lib'
          File.open(file_path, 'w') do |f|
            f.write Strpg::Template.new(file_path).lib_template
          end
        when 'test'
          File.open(file_path, 'w') do |f|
            f.write Strpg::Template.new(file_path).test_template
          end
        else
          FileUtils.touch file_path
        end
      end

      puts "create new file #{file_path}"
    end

    def remove_file file_path
      writable_exec(get_dir file_path) do 
        FileUtils.rm file_path
      end
    end

private
    
    def writable_exec dir, rescue_proc=nil
      begin
        unless (File.writable? dir)
          FileUtils.chmod('u+w', dir) 
          yield
          FileUtils.chmod('u-w', dir)
        else
          yield
        end
      rescue
        puts "no such dir #{dir}"
        rescue_proc.() if rescue_proc
      end
    end
  end
end
