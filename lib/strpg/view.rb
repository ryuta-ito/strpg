require 'color_echo'
require_relative './task_manager.rb'

module Strpg
  module View
    def task_messages_colored tasks
      tasks.each do |task| 
        CE.fg task.color
        puts task.message
        puts "writable files: #{task.file_strictions}"
        CE.fg :white
        puts '--'
      end
    end

    def task_view file_paths
      file_paths.each do |file_path|
        tasks = (TaskManager.task_extract_without_finished file_path).tasks
        if tasks != []
          puts
          puts file_path
          task_messages_colored tasks
        end
      end
    end

    def task_view_all file_paths
      file_paths.each do |file_path|
        puts
        puts file_path
        task_messages_colored (TaskManager.task_extract file_path).tasks
      end
    end
  end
end
