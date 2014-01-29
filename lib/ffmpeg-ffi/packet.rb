require 'ffmpeg-ffi/c'

module FFmpeg
  class Packet
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def free
      C::AVCodec.av_free_packet(@ptr)
      @ptr = FFI::Pointer::NULL
    end

    def pts
      @ptr[:pts]
    end

    def pts=(n)
      @ptr[:pts] = n
    end

    def dts
      @ptr[:dts]
    end

    def dts=(n)
      @ptr[:dts] = n
    end

    def stream_index
      @ptr[:stream_index]
    end

    def duration
      @ptr[:duration]
    end

    def duration=(n)
      @ptr[:duration] = n
    end

    def pos=(n)
      @ptr[:pos] = n
    end
  end
end
