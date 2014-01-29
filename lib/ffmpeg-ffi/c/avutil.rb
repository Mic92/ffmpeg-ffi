require 'ffmpeg-ffi/c/dictionary'
require 'ffmpeg-ffi/c/rational'

module FFmpeg
  module C
    module AVUtil
      extend FFI::Library
      ffi_lib ['libavutil.so.52']

      attach_function :avutil_version, [], :uint
      attach_function :avutil_configuration, [], :string
      attach_function :avutil_license, [], :string

      attach_function :av_strerror, [:int, :buffer_out, :size_t], :int
      attach_function :av_log_get_level, [], :int
      attach_function :av_log_set_level, [:int], :void

      attach_function :av_dict_count, [Dictionary.by_ref], :int
      attach_function :av_dict_get, [Dictionary.by_ref, :string, DictionaryEntry.by_ref, :int], DictionaryEntry.by_ref
      attach_function :av_dict_set, [:pointer, :string, :string, :int], :int

      attach_function :av_get_media_type_string, [:int], :string

      NOPTS_VALUE = 0x8000000000000000
      TIME_BASE = 1000000

      # math
      attach_function :av_rescale, [:int64, :int64, :int64], :int64
      attach_function :av_rescale_rnd, [:int64, :int64, :int], :int64
      attach_function :av_rescale_q, [:int64, C::Rational.by_value, C::Rational.by_value], :int64
      attach_function :av_rescale_q_rnd, [:int64, C::Rational.by_value, C::Rational.by_value, :int], :int64
    end
  end
end
