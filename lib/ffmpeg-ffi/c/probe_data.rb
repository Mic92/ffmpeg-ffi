require 'ffi'

module FFmpeg
  module C
    class ProbeData < FFI::Struct
      layout(
        :filename, :string,
        :buf, :pointer,
        :buf_size, :int,
      )
    end
  end
end
