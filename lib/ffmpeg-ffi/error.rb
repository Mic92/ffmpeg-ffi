require 'ffmpeg-ffi/c'

module FFmpegFFI
  class Error < StandardError
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
