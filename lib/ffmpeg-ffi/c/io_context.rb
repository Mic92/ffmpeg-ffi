require 'ffi'

module FFmpegFFI
  module C
    class IOContext < FFI::Struct
      layout(
        :av_class, :pointer,
        # and more...
      )
    end
  end
end
