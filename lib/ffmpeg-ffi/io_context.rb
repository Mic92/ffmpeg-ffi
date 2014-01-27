require 'ffmpeg-ffi/c'

module FFmpeg
  class IOContext
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def seek(offset, whence)
      C::AVFormat.avio_seek(@ptr, offset, whence)
    end
  end
end
