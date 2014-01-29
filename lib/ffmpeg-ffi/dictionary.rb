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

    Flags = FFI::Enum.new([
      :match_case     , 1,
      :ignore_suffix  , 2,
      :dont_strdup_key, 4,
      :dont_strdup_val, 8,
      :dont_overwrite , 16,
      :append         , 32,
    ])

    def each_entry(key = '', flags, &block)
      entry = nil
      loop do
        entry = C::AVUtil.av_dict_get(@ptr, key, entry, BitFlag.new(Flags, flags).to_i)
        break if entry.null?
        block.call(DictionaryEntry.new(entry))
      end
    end
  end
end
