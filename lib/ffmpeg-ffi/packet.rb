require 'ffmpeg-ffi/c'

module FFmpeg
  class Packet
    include StructCommon
    field_accessor :pts, :dts, :stream_index, :duration, :pos

    def free
      C::AVCodec.av_free_packet(@ptr)
      @ptr = FFI::Pointer::NULL
    end
  end
end
