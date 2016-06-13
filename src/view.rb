require 'color_echo'

module View
  def task_messages_colored tasks
    tasks.each do |task| 
      CE.fg task.color
      puts task.message
      CE.fg :white
      puts '--'
    end
  end

  module_function :task_messages_colored
end
