require 'ffi'

module FFmpeg
  module C
    class Codec < FFI::Struct
      layout(
        :name, :string,
        :long_name, :string,
        # and more...
      )
    end
  end
end
