require_relative '../src/edit_control.rb'
require_relative '../src/dirs.rb'
require 'test/unit'

class TestEditControl < Test::Unit::TestCase
  include EditControl

  def teardown
    do_writable_all
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
end

