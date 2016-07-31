require 'strpg/edit_control'
require 'strpg/task_extract'
require 'test/unit'
require 'erb'

class TestEditControl < Test::Unit::TestCase
  include Strpg::EditControl
  include Strpg::TaskExtract

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
    bool = (Strpg::Dirs::WRITABLE_DIRS - unfinished_task_file_striction_paths).map do |dir_pattern|
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
    bool = Strpg::Dirs::WRITABLE_DIRS.map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        File.writable? file_path
      end.reduce{|a, b| a and b}
    end.reduce{|a, b| a and b}
    assert_equal true, bool
  end

  def test_unwritable_all
    do_unwritable_all
    bool = Strpg::Dirs::WRITABLE_DIRS.map do |dir_pattern|
      (Dir.glob dir_pattern).map do |file_path|
        File.writable? file_path
      end.reduce{|a, b| a or b}
    end.reduce{|a, b| a or b}
    assert_equal false, bool
  end

  # test 'create_file' do
  #   create_file './sample/asdf'
  #   assert_equal true, (File.file?'./sample/asdf')
  #   (FileUtils.rm './sample/asdf', {:force => true}) if File.file? './sample/asdf'
  # end
  
  test 'create_file_and_dir' do
    dir = './sample/asdf'
    file = 'asdf'
    file_path = File.join dir, file
    create_file file_path
    assert_equal true, (File.file? file_path)
    remove_file file_path
  end

  test 'create file using template' do
    file_path = './lib/strpg/asdf.rb'
    create_file file_path

    file1 = File.open './template/lib.erb' do |f|
      cap_prj_name = 'strpg'.capitalize
      cap_pure_name = 'asdf'.capitalize
      ERB.new(f.read).result(binding)
    end

    file2 = File.open(file_path) { |f| f.read }
    remove_file file_path
    assert_equal file1, file2

    file_path = './test/test_asdf.rb'
    create_file file_path
    
    file1 = File.open './template/test.erb' do |f|
      cap_pure_test_name = 'asdf'.capitalize
      ERB.new(f.read).result(binding)
    end
    
    file2 = File.open(file_path) { |f| f.read }
    remove_file file_path
    assert_equal file1, file2
    remove_file file_path
  end

  test 'get_file_name' do
    file_path = './path/to/file_name'
    assert_equal 'file_name', (get_file_name file_path)
  end

  test 'erase_file_identifier' do
    file_name = 'file.rb'
    assert_equal 'file', (erase_file_identifier file_name)
  end
  
  test 'get_pure_name' do
    file_path = './path/to/file.rb'
    assert_equal 'file', (get_pure_name file_path)
  end

  test 'get_pure_test_name' do
    file_path = './path/to/test_file.rb'
    assert_equal 'file', (get_pure_test_name file_path) 
    
    file_path = './path/to/test.rb'
    assert_equal '', (get_pure_test_name file_path) 
  end
end

