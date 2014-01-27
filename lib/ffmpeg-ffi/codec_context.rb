require 'ffmpeg-ffi'

module FFmpeg
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

    def codec_type
      @ptr[:codec_type]
    end

    def codec_type_string
      C::AVUtil.av_get_media_type_string(codec_type)
    end

    def codec
      unless @ptr[:codec].null?
        Codec.new(@ptr[:codec])
      end
    end

    def codec_id
      @ptr[:codec_id]
    end

    def codec_name
      C::AVCodec.avcodec_get_name(codec_id)
    end

    def width
      @ptr[:width]
    end

    def height
      @ptr[:height]
    end
  end
end
