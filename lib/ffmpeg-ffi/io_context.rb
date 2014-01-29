require 'ffmpeg-ffi'
require 'ffmpeg-ffi/c'

module FFmpeg
  class IOContext
    include StructCommon

    READ = 1
    WRITE = 2
    READ_WRITE = READ | WRITE

    def self.open(url, flag)
      ptr = FFI::MemoryPointer.new(:pointer)
      raise_averror do
        C::AVFormat.avio_open(ptr, url, flag)
      end
      new(C::IOContext.new(ptr.read_pointer))
    end

    def seek(offset, whence)
      C::AVFormat.avio_seek(@ptr, offset, whence)
    end

    def close
      raise_averror do
        C::AVFormat.avio_close(@ptr)
      end
    end
  end
end
