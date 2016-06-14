module TaskExtract
  class Task
    def initialize task_str, result_str, reason_str
      @task_str = task_str
      @result_str = result_str
      @reason_str = reason_str
    end

    def message
      (finished? ? finished : not_finished) + "\n" + (exist_reason? ? exist_reason : reason_is_nothing )
    end
    
    def not_finished
      "( #{task} ) is not finished"
    end

    def finished
      "( #{task} ) is finished ( #{result} )"
    end

    def exist_reason
      "the reason is ( #{reason} )"
    end

    def reason_is_nothing
      "the reason is nothing"
    end

    def color
      finished? ? (exist_reason? ? :index47 : :green) : (exist_reason? ? :index197 : :red)
    end

    def task
      @task_str.chomp.chars.drop(2).join
    end

    def result
      @result_str.chomp.chars.drop(2).join
    end

    def reason
      @reason_str.chomp.chars.drop(5).join
    end

    def finished?
      @result_str.nil? ? false : true
    end

    def exist_reason?
      @reason_str.nil? ? false : true
    end
  end
end
