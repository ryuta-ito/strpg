require_relative './factory.rb'
require_relative './view.rb'

module TaskCheck
  def task_syntax_right? file_path
    open(file_path) { |file| file.read }
  end

  def task_check file_path
    task_manager = Factory.task_manager
    task_manager.task_extract file_path
    task_manager.task_massages
  end

  def task_check_with_reason file_path
    task_manager = Factory.task_manager
    task_manager.task_extract_with_reason file_path
    task_manager.task_massages
  end

  def task_view file_path
    task_manager = Factory.task_manager
    task_manager.task_extract file_path
    View.task_messages_colored task_manager.tasks
  end

  def task_view_with_reason file_path
    task_manager = Factory.task_manager
    task_manager.task_extract_with_reason file_path
    View.task_messages_colored task_manager.tasks
  end
end
