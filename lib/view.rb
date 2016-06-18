require 'color_echo'
require_relative './factory.rb'

module View
  def task_messages_colored tasks
    tasks.each do |task| 
      CE.fg task.color
      puts task.message
      CE.fg :white
      puts '--'
    end
  end

  def task_view file_paths
    file_paths.each do |file_path|
      puts
      puts file_path
      task_manager = Factory.task_manager
      task_manager.task_extract file_path
      task_messages_colored task_manager.tasks
    end
  end
end
