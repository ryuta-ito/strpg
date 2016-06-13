require_relative '../src/task_check.rb'
require 'test/unit'

class TestTaskCheck < Test::Unit::TestCase
  include TaskCheck

  def test_task_check
    expected_str = "( task1 ) is not finished\n( task2 ) is finished ( something text )\n"
    assert_equal expected_str, (task_check './task/test_task')

    expected_str = "( task1 ) is not finished\n( task2 ) is not finished\n"
    assert_equal expected_str, (task_check './task/test_task_2')

    expected_str = "( task1 ) is finished ( something text )\n( task2 ) is not finished\n"
    assert_equal expected_str, (task_check './task/test_task_3')

    expected_str = "( task1 ) is finished ( something text )\n( task2 ) is finished ( something text )\n"
    assert_equal expected_str, (task_check './task/test_task_4')
  end
end

