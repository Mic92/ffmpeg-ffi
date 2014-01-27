require 'ffi'

module FFmpeg
  module C
    class IOContext < FFI::Struct
      layout(
        :av_class, :pointer,
        # and more...
      )
    end
  end
end
