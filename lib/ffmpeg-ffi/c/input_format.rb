require 'ffi'

module FFmpegFFI
  module C
    class InputFormat < FFI::Struct
      layout(
        :name, :string,
        :long_name, :string,
        :flags, :int,
        :extensions, :string,
        :codec_tag, :pointer,
        :priv_class, :pointer,
        # and more...
      )
    end
  end
end
