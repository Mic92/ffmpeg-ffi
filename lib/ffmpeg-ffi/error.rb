require 'ffmpeg-ffi/c'

module FFmpeg
  class Error < StandardError
    def self.errtag(str)
      -(str[0].ord | (str[1].ord << 8) | (str[2].ord << 16) | (str[3].ord << 24))
    end

    EOF = errtag('EOF ')

    attr_reader :errno
    def initialize(errno)
      size = 64
      FFI::Buffer.new(:char, size) do |buf|
        C::AVUtil.av_strerror(errno, buf, size)
        super(buf.get_string(0))
      end
      @errno = errno
    end
  end
end
