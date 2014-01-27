require 'ffmpeg-ffi/c'

module FFmpeg
  class OutputFormat
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

    def flags
      @ptr[:flags]
    end

    def globalheader?
      (flags & C::AVFormat::GLOBALHEADER) != 0
    end

    def nofile?
      (flags & C::AVFormat::NOFILE) != 0
    end
  end
end
