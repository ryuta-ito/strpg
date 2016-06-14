require_relative '../src/task_extract.rb'
require 'test/unit'

class TestTaskExtract < Test::Unit::TestCase
  include TaskExtract

  def test_task_extract_with
    expected_str = "( task1 ) is not finished\n( task2 ) is finished ( something text )\n"
    # assert_equal expected_str, (task_extract './task/test_task')

    expected_str = "( task1 ) is not finished\n( task2 ) is not finished\n"
    # assert_equal expected_str, (task_extract './task/test_task_2')

    expected_str = "( task1 ) is finished ( something text )\n( task2 ) is not finished\n"
    # assert_equal expected_str, (task_extract './task/test_task_3')

    expected_str = "( task1 ) is finished ( something text )\n( task2 ) is finished ( something text )\n"
    # assert_equal expected_str, (task_extract './task/test_task_4')
  end
end

