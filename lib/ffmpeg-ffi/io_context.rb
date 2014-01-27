require 'ffmpeg-ffi'
require 'ffmpeg-ffi/c'

module FFmpeg
  class IOContext
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    READ = 1
    WRITE = 2
    READ_WRITE = READ | WRITE

    def self.open(url, flag)
      ptr = FFI::MemoryPointer.new(:pointer)
      r = C::AVFormat.avio_open(ptr, url, flag)
      if r < 0
        raise Error.new(r)
      end
      new(C::IOContext.new(ptr.read_pointer))
    end

    def seek(offset, whence)
      C::AVFormat.avio_seek(@ptr, offset, whence)
    end
  end
end
