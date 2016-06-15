require_relative './factory.rb'

module TaskExtract
  def task_extract file_path
    task_manager = Factory.task_manager
    task_manager.task_extract file_path
    task_manager
  end
end
