require 'ffmpeg-ffi/c/codec'

module FFmpegFFI
  module C
    class CodecContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :log_level_offset, :int,
        :codec_type, :int,
        :codec, Codec.by_ref,
        :codec_name, [:char, 32],
        :codec_id, :int,
        # and more...
      )
    end
  end
end
