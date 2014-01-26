require 'ffmpeg-ffi/c'

module FFmpegFFI
  class Codec
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
  end
end
