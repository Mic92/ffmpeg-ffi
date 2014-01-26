require 'ffi'

module FFmpegFFI
  module C
    module AVUtil
      extend FFI::Library
      ffi_lib ['libavutil.so.52']

      attach_function :av_log_get_level, [], :int
      attach_function :av_log_set_level, [:int], :void
    end
  end
end
