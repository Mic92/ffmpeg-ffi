require 'ffmpeg-ffi/c/codec'
require 'ffmpeg-ffi/c/format_context'

module FFmpegFFI
  module C
    module AVCodec
      extend FFI::Library
      ffi_lib ['libavcodec.so.55']

      attach_function :avcodec_version, [], :uint
      attach_function :avcodec_configuration, [], :string
      attach_function :avcodec_license, [], :string

      attach_function :avcodec_string, [:buffer_in, :int, CodecContext.by_ref, :int], :void
      attach_function :avcodec_get_name, [:int], :string
      attach_function :avcodec_find_decoder, [:int], Codec.by_ref
    end
  end
end
