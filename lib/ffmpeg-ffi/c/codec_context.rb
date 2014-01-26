require 'ffi'

module FFmpegFFI
  module C
    class CodecContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :log_level_offset, :int,
        :codec_type, :int,
        :codec, :pointer,
        :codec_name, [:char, 32],
        # and more...
      )
    end
  end
end
