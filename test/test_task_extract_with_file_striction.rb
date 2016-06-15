require_relative '../src/task_extract.rb'
require 'test/unit'

class TestTaskExtract < Test::Unit::TestCase
  include TaskExtract

  def test_task_extract_with_file_striction
    task = (task_extract './task/sample/task_with_file_striction').tasks.first
    assert_equal [task.task, task.reason, task.file_strictions.first, task.result], ['task', 'reason', 'path/file', 'result']
  end
end

