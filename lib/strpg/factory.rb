require_relative './task_manager.rb'

module Factory
  include TaskExtract

  def task_manager
    TaskManager.new
  end

  module_function :task_manager
end
