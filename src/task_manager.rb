require_relative './task.rb'

module TaskExtract
  class TaskManager #Taskのfactory
    attr_reader :tasks

    def initialize
      @tasks = []
    end

    def add_task task_str, result_str=nil, reason=nil, file_striction=nil
      @tasks << (Task.new task_str, result_str, reason, file_striction)
    end

    def task_extract file_path
      lines = []
      result_lines = []
      File.foreach(file_path) { |line| lines << line }

      lines.each_cons(2) do |line_1, line_2|
        if (tasks? [line_1, line_2])
          add_task line_1
        elsif (task? line_1) and !(task? line_2)
          add_task line_1, line_2
        end
      end

      add_task lines.last if (task? lines.last)
    end

    def task_extract_with_reason file_path
      lines = []
      result_lines = []
      File.foreach(file_path) { |line| lines << line }

      lines.each.with_index do |line, i|
        if task? line
          reason = ((reason? lines[i+1]) ? lines[i+1] : nil)
          result = ((result? lines[i+2]) ? lines[i+2] : nil)
          add_task line, result, reason
        end
      end
    end

    def task_extract_with_file_striction file_path
      lines = []
      result_lines = []
      File.foreach(file_path) { |line| lines << line }

      lines.each.with_index do |line, i|
        if task? line
          reason = ((reason? lines[i+1]) ? lines[i+1] : nil)
          file_striction = ((file_striction? lines[i+2]) ? lines[i+2] : nil)
          result = ((result? lines[i+3]) ? lines[i+3] : nil)
          add_task line, result, reason, file_striction
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
