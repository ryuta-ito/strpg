require_relative 'dirs.rb'

module EditControl
  def do_writable_files file_paths
    file_paths.each do |file_path| FileUtils.chmod('u+w', file_path) end
  end

  def do_unwritable_files file_paths
    file_paths.each do |file_path| FileUtils.chmod('u-w', file_path) end
  end

  def do_writable_all
    change_dirs_writable Dirs::WRITABLE_DIRS, 'u+w'
  end

  def do_unwritable_all
    change_dirs_writable Dirs::WRITABLE_DIRS, 'u-w'
  end

  def change_dirs_writable dirs, mode
    dirs.map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        FileUtils.chmod(mode, file_path)
      end
    end
  end
end
