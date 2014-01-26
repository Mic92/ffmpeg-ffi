require 'ffmpeg-ffi'

module FFmpegFFI
  class CodecContext
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def string(is_encode)
      size = 256
      FFI::Buffer.new(:char, size) do |buf|
        C::AVCodec.avcodec_string(buf, size, @ptr, is_encode ? 1 : 0)
        return buf.get_string(0)
      end
    end
  end
end
