require 'ffmpeg-ffi'

module FFmpeg
  class CodecContext
    include StructCommon
    field_accessor :codec_type, :codec_id, :width, :height, :profile

    def string(is_encode)
      size = 256
      FFI::Buffer.new(:char, size) do |buf|
        C::AVCodec.avcodec_string(buf, size, @ptr, is_encode ? 1 : 0)
        return buf.get_string(0)
      end
    end

    def media_type_string
      C::AVUtil.av_get_media_type_string(codec_type)
    end

    def codec
      unless @ptr[:codec].null?
        Codec.new(@ptr[:codec])
      end
    end

    def codec_name
      C::AVCodec.avcodec_get_name(codec_id)
    end

    Flags = FFI::Enum.new([
      :input_preserved, 0x0100,
      :pass1          , 0x0200,
      :pass2          , 0x0400,
      :gray           , 0x2000,
      :emu_edge       , 0x4000,
      :psnr           , 0x8000,
      :truncated      , 0x00010000,
      :normalize_aqp  ,0x00020000,
      :interlaced_dct ,0x00040000,
      :low_delay      ,0x00080000,
      :global_header  ,0x00400000,
      :bitexact       ,0x00800000,
      :ac_pred        ,0x01000000,
      :loop_filter    ,0x00000800,
      :interlaced_me  ,0x20000000,
      :closed_gop     ,0x80000000,
    ])

    def flags
      BitFlag.new(Flags, @ptr[:flags])
    end
    private :flags

    def flags=(flags)
      @ptr[:flags] = flags.to_i
    end
    private :flags=

    def global_header=(flag)
      self.flags = flags.set(:global_header, flag)
    end

    def copy_from(codec_ctx)
      raise_averror do
        C::AVCodec.avcodec_copy_context(@ptr, codec_ctx.ptr)
      end
      self
    end
  end
end
