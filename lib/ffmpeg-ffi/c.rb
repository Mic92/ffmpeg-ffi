require 'ffi'

module FFmpegFFI
  module C
    autoload :AVFormat, 'ffmpeg-ffi/c/avformat'
    autoload :AVUtil, 'ffmpeg-ffi/c/avutil'

    autoload :Dictionary, 'ffmpeg-ffi/c/dictionary'
    autoload :DictionaryEntry, 'ffmpeg-ffi/c/dictionary_entry'
    autoload :Frac, 'ffmpeg-ffi/c/frac'
    autoload :Rational, 'ffmpeg-ffi/c/rational'
    autoload :FormatContext, 'ffmpeg-ffi/c/format_context'
    autoload :InputFormat, 'ffmpeg-ffi/c/input_format'
    autoload :Program, 'ffmpeg-ffi/c/program'
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
