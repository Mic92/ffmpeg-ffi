require 'ffi'

module FFmpegFFI
  module C
    class DictionaryEntry < FFI::Struct
      layout(
        :key, :string,
        :value, :string,
      )
    end
  end
end
