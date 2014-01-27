require 'ffi'

module FFmpeg
  module C
    class DictionaryEntry < FFI::Struct
      layout(
        :key, :string,
        :value, :string,
      )
    end
  end
end
