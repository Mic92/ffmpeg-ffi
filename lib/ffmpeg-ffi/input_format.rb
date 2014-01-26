module FFmpegFFI
  class InputFormat
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def name
      @ptr[:name]
    end

    def long_name
      @ptr[:long_name]
    end

    def extensions
      @ptr[:extensions]
    end
  end
end
