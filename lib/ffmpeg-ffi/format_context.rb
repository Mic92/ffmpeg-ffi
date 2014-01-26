require 'ffmpeg-ffi/c'

module FFmpegFFI
  class FormatContext
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def self.open_input(path)
      ptr = FFI::MemoryPointer.new(C::FormatContext.by_ref)
      r = C::AVFormat.avformat_open_input(ptr, path.to_s, nil, nil)
      if r < 0
        raise Error.new(r)
      end
      FormatContext.new(C::FormatContext.new(ptr.get_pointer(0)))
    end

    def close_input
      ptr = FFI::MemoryPointer.new(C::FormatContext.by_ref)
      C::AVFormat.avformat_close_input(ptr)
      @ptr = ptr.get_pointer(0)
    end

    def find_stream_info
      r = C::AVFormat.avformat_find_stream_info(@ptr, nil)
      if r < 0
        raise Error.new(r)
      end
      self
    end

    def iformat
      InputFormat.new(@ptr[:iformat])
    end

    def filename
      @ptr[:filename]
    end

    def start_time
      if @ptr[:start_time] != C::AVUtil::NOPTS_VALUE
        @ptr[:start_time].to_r / C::AVUtil::TIME_BASE
      end
    end

    def duration
      if @ptr[:duration] != C::AVUtil::NOPTS_VALUE
        @ptr[:duration].to_r / C::AVUtil::TIME_BASE
      end
    end

    def bit_rate
      if @ptr[:bit_rate] != C::AVUtil::NOPTS_VALUE
        @ptr[:bit_rate]
      end
    end

    def dump_format(index, url, is_output)
      C::AVFormat.av_dump_format(@ptr, index, url, is_output ? 1 : 0)
    end
  end
end
