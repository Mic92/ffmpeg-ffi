require 'ffmpeg-ffi/c'

module FFmpeg
  class Dictionary
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def count
      C::AVUtil.av_dict_count(@ptr)
    end

    MATCH_CASE      = 1
    IGNORE_SUFFIX   = 2
    DONT_STRDUP_KEY = 4
    DONT_STRDUP_VAL = 8
    DONT_OVERWRITE  = 16
    APPEND          = 32

    def each_entry(key = '', flags = 0, &block)
      entry = nil
      loop do
        entry = C::AVUtil.av_dict_get(@ptr, key, entry, flags)
        break if entry.null?
        block.call(DictionaryEntry.new(entry))
      end
    end
  end
end
