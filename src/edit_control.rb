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
      FileUtils.chmod(mode, file_path)
    end
  end
end
