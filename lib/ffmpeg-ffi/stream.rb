module FFmpegFFI
  class Stream
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def id
      @ptr[:id]
    end

    def index
      @ptr[:index]
    end
  end
end
