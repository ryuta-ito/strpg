require_relative './factory.rb'

module TaskExtract
  def task_extract file_path
    task_manager = Factory.task_manager
    task_manager.task_extract file_path
    task_manager
  end

  def file_striction_extract file_path
    TaskManager.file_striction_extract file_path
  end
end
