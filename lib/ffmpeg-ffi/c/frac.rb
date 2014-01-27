require 'ffi'

module FFmpeg
  module C
    class Frac < FFI::Struct
      layout(
        :val, :int64,
        :num, :int64,
        :den, :int64,
      )
    end
  end
end
