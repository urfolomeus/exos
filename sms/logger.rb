module SMS

  class Logger

    attr_reader :messages
    def initialize
      @messages = []
    end

    def error(message)
      messages << message
    end

  end

end

