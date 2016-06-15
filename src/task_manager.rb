require_relative './task.rb'
require_relative './line.rb'

module TaskExtract
  class TaskManager #Taskのfactory
    attr_reader :tasks

    def initialize
      @tasks = []
    end

    def add_task(task_str: , result_str: nil, reason_str: nil, file_striction_str: nil)
      @tasks << (Task.new task_str: task_str, result_str: result_str, reason_str: reason_str, file_striction_str: file_striction_str)
    end

    def task_extract file_path
      lines = []
      result_lines = []
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

          add_task task
        end
      end
    end

    def task_massages
      @tasks.map{|task| task.message}.join("\n") + "\n"
    end

    def tasks? strs
      strs.each do |str|
        return false unless (task? str)
      end
      true
    end

    def task? task_str
      task_str.chars.first == '-' ? true : false
    end

    def result? result_str
      result_str = "" if result_str.class != String
      (result_str.match /^  .+/) ? true : false
    end

    def reason? reason_str
      reason_str = "" if reason_str.class != String
      (reason_str.match /^  <- .+/) ? true : false
    end

    def file_striction? file_striction_str
      file_striction_str = "" if file_striction_str.class != String
      (file_striction_str.match /^  * .+/) ? true : false
    end
  end
end
