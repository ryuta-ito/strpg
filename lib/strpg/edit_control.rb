require_relative 'dirs.rb'
require_relative 'task_manager.rb'

module EditControl
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
    end
  end

  def create_file file_path
    dir = (file_path.split '/').reverse.drop(1).reverse.join '/'

    begin
      FileUtils.chmod('u+w', dir)
    rescue
      puts "no such dir #{dir}\n create it"
      FileUtils.mkdir_p dir
    end

    FileUtils.touch file_path
    FileUtils.chmod('u-w', dir)
    puts "create new file #{file_path}"
  end
end
