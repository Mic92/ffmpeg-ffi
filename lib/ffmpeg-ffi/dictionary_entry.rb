require 'ffmpeg-ffi/c'

module FFmpeg
  class DictionaryEntry
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def key
      @ptr[:key]
    end

    def value
      @ptr[:value]
    end
  end
end
