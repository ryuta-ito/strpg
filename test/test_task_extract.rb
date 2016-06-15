require_relative '../src/task_extract.rb'
require 'test/unit'

class TestTaskExtract < Test::Unit::TestCase
  include TaskExtract

  def test_task_extract
    expected_str = "( task1 ) is not finished\nthe reason is nothing\n( task2 ) -> ( something text )\nthe reason is nothing\n"
    assert_equal expected_str, (task_extract './task/sample/test_task').task_massages

    expected_str = "( task1 ) is not finished\nthe reason is nothing\n( task2 ) is not finished\nthe reason is nothing\n"
    assert_equal expected_str, (task_extract './task/sample/test_task_2').task_massages

    expected_str = "( task1 ) -> ( something text )\nthe reason is nothing\n( task2 ) is not finished\nthe reason is nothing\n"
    assert_equal expected_str, (task_extract './task/sample/test_task_3').task_massages

    expected_str = "( task1 ) -> ( something text )\nthe reason is nothing\n( task2 ) -> ( something text )\nthe reason is nothing\n"
    assert_equal expected_str, (task_extract './task/sample/test_task_4').task_massages
  end
end

