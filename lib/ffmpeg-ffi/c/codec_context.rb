require 'ffmpeg-ffi/c/codec'
require 'ffmpeg-ffi/c/rational'

module FFmpeg
  module C
    class CodecContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :log_level_offset, :int,
        :codec_type, :int,
        :codec, Codec.by_ref,
        :codec_name, [:char, 32],
        :codec_id, :int,
        :codec_tag, :uint,
        :stream_codec_tag, :uint,
        :priv_data, :pointer,
        :internal, :pointer,
        :opaque, :pointer,
        :bit_rate, :int,
        :bit_rate_tolerance, :int,
        :global_quality, :int,
        :compression_level, :int,
        :flags, :int,
        :flags2, :int,
        :extradata, :pointer,
        :extradata_size, :int,
        :time_base, Rational.by_value,
        :ticks_per_frame, :int,
        :delay, :int,
        :width, :int,
        :height, :int,
        # and more...
      )
    end
  end
end
