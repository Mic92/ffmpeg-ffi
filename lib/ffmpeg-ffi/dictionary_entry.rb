require 'ffmpeg-ffi/c'

module FFmpegFFI
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
