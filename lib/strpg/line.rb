module TaskExtract
  class Line
    attr_reader :str

    def initialize line_str
      @str = line_str
    end

    def task?
      @str.chars.first == '-' ? true : false
    end

    def reason?
      @str = "" if @str.class != String
      (@str.match /^  <- .+/) ? true : false
    end

    def file_striction?
      @str = "" if @str.class != String
      (@str.match /^  \* .+/) ? true : false
    end

    def result?
      @str = "" if @str.class != String
      (@str.match /^  -> .+/) ? true : false
    end
  end
end
