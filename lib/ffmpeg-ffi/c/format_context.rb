require 'ffi'

module FFmpegFFI
  module C
    class FormatContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :iformat, :pointer,
        :oformat, :pointer,
        :priv_data, :pointer,
        # and more...
      )
    end
  end
end
