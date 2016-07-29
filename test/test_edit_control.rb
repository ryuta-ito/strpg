require 'strpg/edit_control'
require 'strpg/task_extract'
require 'test/unit'

class TestEditControl < Test::Unit::TestCase
  include EditControl
  include TaskExtract

  def teardown
    do_writable_all
  end

  def test_unfinished_task_file_striction
    unfinished_task_file_striction_paths = file_striction_extract './task/sample/file_striction/test_task_file_striction_extract'
    do_unwritable_all
    do_writable_files unfinished_task_file_striction_paths
    # p Dirs::WRITABLE_DIRS
    # p unfinished_task_file_striction_paths
    # exit
    bool = (Dirs::WRITABLE_DIRS - unfinished_task_file_striction_paths).map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        File.writable? file_path
      end.reduce{|a, b| a or b}
    end.reduce{|a, b| a or b}
    bool = bool or !(File.writable? './task/sample/file_striction/test_task_file_striction_extract')
    assert_equal false, bool
  end

  def test_unwritable_files
    do_unwritable_files ['./test/test_task_extract.rb']
    bool = File.writable? './test/test_task_extract.rb'
    assert_equal false, bool
  end

  def test_writable_files
    do_writable_files ['./test/test_task_extract.rb']
    bool = File.writable? './test/test_task_extract.rb'
    assert_equal true, bool
  end

  def test_writable_all
    do_writable_all
    bool = Dirs::WRITABLE_DIRS.map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        File.writable? file_path
      end.reduce{|a, b| a and b}
    end.reduce{|a, b| a and b}
    assert_equal true, bool
  end

  def test_unwritable_all
    do_unwritable_all
    bool = Dirs::WRITABLE_DIRS.map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        File.writable? file_path
      end.reduce{|a, b| a or b}
    end.reduce{|a, b| a or b}
    assert_equal false, bool
    do_writable_all
  end

  # test 'create_file' do
  #   create_file './sample/asdf'
  #   assert_equal true, (File.file?'./sample/asdf')
  #   (FileUtils.rm './sample/asdf', {:force => true}) if File.file? './sample/asdf'
  # end
  
  test 'create_file_and_dir' do
    dir = './sample/asdf'
    file_path = File.join './sample/asdf', 'asdf'
    create_file file_path
    assert_equal true, (File.file? file_path)

    if File.file? file_path
      FileUtils.chmod 'u+w', dir
      FileUtils.rm file_path
      FileUtils.rmdir dir
    end
  end
end

