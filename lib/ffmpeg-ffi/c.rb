require 'ffi'

module FFmpegFFI
  module C
    autoload :AVFormat, 'ffmpeg-ffi/c/avformat'
    autoload :AVUtil, 'ffmpeg-ffi/c/avutil'

    autoload :FormatContext, 'ffmpeg-ffi/c/format_context'

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