require 'ffmpeg-ffi/c/dictionary_entry'

module FFmpeg
  module C
    class Dictionary < FFI::Struct
      layout(
        :count, :int,
        :elems, DictionaryEntry.by_ref,
      )
    end
  end
end
