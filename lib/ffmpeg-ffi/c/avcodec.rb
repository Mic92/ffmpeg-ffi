require 'ffmpeg-ffi/c/format_context'

module FFmpegFFI
  module C
    module AVCodec
      extend FFI::Library
      ffi_lib ['libavcodec.so.55']

      attach_function :avcodec_string, [:buffer_in, :int, CodecContext.by_ref, :int], :void
    end
  end
end
