require 'ffmpeg-ffi/c/input_format'

module FFmpegFFI
  module C
    class FormatContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :iformat, InputFormat.by_ref,
        :oformat, :pointer,
        :priv_data, :pointer,
        :pb, :pointer,
        :ctx_flags, :int,
        :nb_streams, :int,
        :streams, :pointer,
        :filename, [:char, 1024],
        :start_time, :int64,
        :duration, :int64,
        # and more...
      )
    end
  end
end
