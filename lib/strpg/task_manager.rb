require 'strpg/task'
require 'strpg/line'

module Strpg
  module TaskExtract
    class TaskManager #Taskのfactory
      attr_reader :tasks

      def initialize
        @tasks = []
      end

      def set_tasks tasks
        @tasks = tasks
      end

      def add_task(task_str: , result_str: nil, reason_str: nil, file_striction_str: nil)
        @tasks << (Task.new task_str: task_str, result_str: result_str, reason_str: reason_str, file_striction_str: file_striction_str)
      end

      def self.task_extract file_path
        task_manager = self.new
        lines = []
        # result_lines = []
        File.foreach(file_path) { |line| lines << Line.new(line) }

        lines.each.with_index do |line, i|
          if line.task?
            task = {task_str: line.str}
            invalid = false

            [lines[i+1], lines[i+2], lines[i+3]].each do |in_line|
              unless in_line.nil?
                case
                when in_line.task?
                  invalid = true
                when in_line.reason?
                  unless invalid then task[:reason_str] = in_line.str end
                when in_line.file_striction?
                  unless invalid then task[:file_striction_str] = in_line.str end
                when in_line.result?
                  unless invalid then task[:result_str] = in_line.str end
                else
                end
              end
            end

            task_manager.add_task task
          end
        end
        task_manager
      end

      def self.task_extract_without_finished file_path
        task_manager = self.new
        task_manager.set_tasks (self.task_extract file_path).tasks.delete_if{|task| task.finished?}
        task_manager
      end

      def self.file_striction_extracts file_paths
        _file_paths = []
        file_paths.each do |file_path|
          _file_paths += self.file_striction_extract file_path
        end
        _file_paths
      end

      def self.file_striction_extract file_path
        tasks = (self.task_extract file_path).tasks
        file_paths = []
        tasks.each do |task|
          unless task.finished?
            task.file_strictions.each do |file_path|
              file_paths << file_path
            end
          end
        end
        file_paths
      end

      def task_massages
        @tasks.map{|task| task.message}.join("\n") + "\n"
      end
    end
  end
end
