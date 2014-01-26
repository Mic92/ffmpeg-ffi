require 'ffmpeg-ffi'

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

    def metadata
      Dictionary.new(@ptr[:metadata])
    end
  end
end
