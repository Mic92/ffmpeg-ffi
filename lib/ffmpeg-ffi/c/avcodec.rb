require 'ffmpeg-ffi/c/codec'
require 'ffmpeg-ffi/c/format_context'

module FFmpeg
  module C
    module AVCodec
      extend FFI::Library
      ffi_lib ['libavcodec.so']

      attach_function :avcodec_version, [], :uint
      attach_function :avcodec_configuration, [], :string
      attach_function :avcodec_license, [], :string

      attach_function :avcodec_string, [:buffer_in, :int, CodecContext.by_ref, :int], :void
      attach_function :avcodec_get_name, [:int], :string
      attach_function :av_get_profile_name, [Codec.by_ref, :int], :string
      attach_function :avcodec_find_decoder, [:int], Codec.by_ref
      attach_function :avcodec_copy_context, [CodecContext.by_ref, CodecContext.by_ref], :int

      attach_function :av_free_packet, [:pointer], :void
    end
  end
end
