require_relative './factory.rb'

module TaskExtract
  def task_extract file_path
    task_manager = Factory.task_manager
    task_manager.task_extract file_path
    task_manager.task_massages
  end

  def task_extract_with_reason file_path
    task_manager = Factory.task_manager
    task_manager.task_extract_with_reason file_path
    task_manager.task_massages
  end
end
