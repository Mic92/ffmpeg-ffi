require 'ffmpeg-ffi/c/input_format'

module FFmpegFFI
  module C
    class FormatContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :iformat, InputFormat.by_ref,
        :oformat, :pointer,
        :priv_data, :pointer,
        # and more...
      )
    end
  end
end
