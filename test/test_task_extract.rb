require_relative '../lib/task_extract.rb'
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

  def test_task_extract_without_finished
    tasks = (task_extract_without_finished './task/sample/test_task_6').tasks
    assert_equal ['task1', 'task3'], tasks.map{|task| task.task} 
  end

  def test_task_extract_with_file_striction
    task = (task_extract './task/sample/test_task_with_file_striction').tasks.first
    assert_equal [task.task, task.reason, task.file_strictions.first, task.result], ['task', 'reason', 'path/file', 'result']
  end

  def test_task_extract_with_file_striction_not_finished
    assert_equal ['./lib/task.rb', './lib/view.rb'], (file_striction_extract './task/sample/file_striction/test_task_file_striction_extract')
    assert_equal [], (file_striction_extract './task/sample/file_striction/test_task_file_striction_extract_1')
  end
end

