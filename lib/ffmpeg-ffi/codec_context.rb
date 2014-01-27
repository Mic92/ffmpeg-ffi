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

    def flags
      @ptr[:flags]
    end

    def flags=(flags)
      @ptr[:flags] = flags
    end

    def global_header=(flag)
      if flag
        self.flags |= C::AVCodec::FLAG_GLOBAL_HEADER
      else
        self.flags &= ~C::AVCodec::FLAG_GLOBAL_HEADER
      end
    end

    def width
      @ptr[:width]
    end

    def height
      @ptr[:height]
    end

    def copy_from(codec_ctx)
      r = C::AVCodec.avcodec_copy_context(@ptr, codec_ctx.ptr)
      if r < 0
        raise Error.new(r)
      end
      self
    end
  end
end
