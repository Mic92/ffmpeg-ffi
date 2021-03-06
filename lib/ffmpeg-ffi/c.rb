require 'ffi'

module FFmpeg
  module C
    autoload :AVCodec, 'ffmpeg-ffi/c/avcodec'
    autoload :AVFormat, 'ffmpeg-ffi/c/avformat'
    autoload :AVUtil, 'ffmpeg-ffi/c/avutil'

    autoload :Codec, 'ffmpeg-ffi/c/codec'
    autoload :CodecContext, 'ffmpeg-ffi/c/codec_context'
    autoload :Dictionary, 'ffmpeg-ffi/c/dictionary'
    autoload :DictionaryEntry, 'ffmpeg-ffi/c/dictionary_entry'
    autoload :FormatContext, 'ffmpeg-ffi/c/format_context'
    autoload :Frac, 'ffmpeg-ffi/c/frac'
    autoload :IOContext, 'ffmpeg-ffi/c/io_context'
    autoload :IOInterruptCB, 'ffmpeg-ffi/c/io_interrupt_cb'
    autoload :InputFormat, 'ffmpeg-ffi/c/input_format'
    autoload :OutputFormat, 'ffmpeg-ffi/c/output_format'
    autoload :Packet, 'ffmpeg-ffi/c/packet'
    autoload :ProbeData, 'ffmpeg-ffi/c/probe_data'
    autoload :Program, 'ffmpeg-ffi/c/program'
    autoload :Rational, 'ffmpeg-ffi/c/rational'
    autoload :Stream, 'ffmpeg-ffi/c/stream'

    module FFIStructHash
      def to_hash
        h = {}
        members.each do |m|
          h[m] = self[m]
        end
        h
      end
      alias_method :to_h, :to_hash
    end
    FFI::Struct.send(:include, FFIStructHash)

    AVFormat.av_register_all
  end
end
