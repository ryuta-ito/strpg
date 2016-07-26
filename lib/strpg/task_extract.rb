require_relative './task_manager.rb'

module TaskExtract
  def task_extract file_path
    TaskManager.task_extract file_path
  end

  def task_extract_without_finished file_path
    TaskManager.task_extract_without_finished file_path
  end

  def file_striction_extract file_path
    TaskManager.file_striction_extract file_path
  end
end
