require 'ffi'

module FFmpegFFI
  module C
    class Stream < FFI::Struct
      layout(
        :index, :int,
        :id, :int,
        # and more
      )
    end
  end
end
