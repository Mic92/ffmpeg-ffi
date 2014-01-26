require 'ffi'

module FFmpegFFI
  module C
    autoload :AVUtil, 'ffmpeg-ffi/c/avutil'

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
  end
end
