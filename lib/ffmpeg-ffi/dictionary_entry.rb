require 'ffmpeg-ffi/c'

module FFmpeg
  class DictionaryEntry
    include StructCommon
    field_accessor :key, :value
  end
end
