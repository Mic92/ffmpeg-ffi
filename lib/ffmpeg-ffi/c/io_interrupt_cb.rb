require 'ffi'

module FFmpeg
  module C
    class IOInterruptCB < FFI::Struct
      layout(
        :callback, :pointer,
        :opaque, :pointer,
      )
    end
  end
end
