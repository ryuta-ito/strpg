require 'thor'

class Strpg < Thor

  desc 'task [option]', 'show task'
  def task
    task_view Dirs::ALL_TASK_DIRS
  end

  desc 'strict [option]', 'strict files'
  option :reset, aliases: '--reset'
  def strict
    case
    when options[:reset] 
      do_writable_all
    else 
      do_writable_only_strict_file
    end
  end

  desc 'init NAME', 'template directory deployment'
  def init name
    ["#{name}/lib", "#{name}/test", "#{name}/task", "#{name}/doc"].each do |dir|
      puts "      create #{dir}"
      FileUtils.mkdir_p dir
    end
    File.open("#{name}/strpg.yml", "w") do |f|
      f.puts "strict_dirs: ['./lib/*', './bin/*', './*']"
      f.puts "strict_files: []"
    end
  end
end

Strpg.start(ARGV)
