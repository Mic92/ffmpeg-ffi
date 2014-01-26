require 'ffmpeg-ffi/c/dictionary'

module FFmpegFFI
  module C
    module AVUtil
      extend FFI::Library
      ffi_lib ['libavutil.so.52']

      attach_function :av_strerror, [:int, :buffer_out, :size_t], :int
      attach_function :av_log_get_level, [], :int
      attach_function :av_log_set_level, [:int], :void

      attach_function :av_dict_count, [Dictionary.by_ref], :int
      attach_function :av_dict_get, [Dictionary.by_ref, :string, DictionaryEntry.by_ref, :int], DictionaryEntry.by_ref
      attach_function :av_dict_set, [:pointer, :string, :string, :int], :int

      NOPTS_VALUE = 0x8000000000000000
      TIME_BASE = 1000000
    end
  end
end
