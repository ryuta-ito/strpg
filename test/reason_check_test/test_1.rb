require_relative '../../src/task_check.rb'
require 'test/unit'

class TestReasonTaskCheck < Test::Unit::TestCase
  include TaskCheck
  
  def test_task_check
    expected_str = "( task1 ) is finished ( result1 )\nthe reason is ( reason1 )\n( task2 ) is finished ( result2 )\nthe reason is ( reason2 )\n"
    assert_equal expected_str, (task_check_with_reason './task/test/reason/task1')

    expected_str = "( task1 ) is not finished\nthe reason is ( reason1 )\n"
    assert_equal expected_str, (task_check_with_reason './task/test/reason/task2')

    expected_str = "( task1 ) is not finished\nthe reason is nothing\n"
    assert_equal expected_str, (task_check_with_reason './task/test/reason/task3')
  end
end

