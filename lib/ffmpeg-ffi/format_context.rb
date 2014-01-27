require 'ffmpeg-ffi'
require 'ffmpeg-ffi/c'

module FFmpeg
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

    def self.alloc_output(oformat, format_name, filename)
      ptr = FFI::MemoryPointer.new(:pointer)
      r = C::AVFormat.avformat_alloc_output_context2(ptr, oformat, format_name, filename)
      if r < 0
        raise Error.new(r)
      end
      ctx = ptr.get_pointer(0)
      unless ctx.null?
        FormatContext.new(C::FormatContext.new(ctx))
      end
    end

    def close_input
      ptr = FFI::MemoryPointer.new(C::FormatContext.by_ref)
      C::AVFormat.avformat_close_input(ptr)
      @ptr = ptr.get_pointer(0)
    end

    def free
      C::AVFormat.avformat_free_context(@ptr)
      @ptr = FFI::Pointer::NULL
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

    def oformat
      OutputFormat.new(@ptr[:oformat])
    end

    def new_stream(codec)
      stream = C::AVFormat.avformat_new_stream(@ptr, codec)
      unless stream.null?
        Stream.new(stream)
      end
    end

    def write_header(options = nil)
      r = C::AVFormat.avformat_write_header(@ptr, options)
      if r < 0
        raise Error.new(r)
      end
      r
    end

    def pb
      IOContext.new(@ptr[:pb])
    end

    def pb=(io_context)
      @ptr[:pb] = io_context.ptr
    end

    def nb_streams
      @ptr[:nb_streams]
    end

    def streams
      @ptr[:streams].read_array_of_type(C::Stream.by_ref, :read_pointer, nb_streams).map do |s|
        Stream.new(C::Stream.new(s))
      end
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

    def nb_programs
      @ptr[:nb_programs]
    end

    def programs
      @ptr[:programs].read_array_of_type(C::Program.by_ref, :read_pointer, nb_programs).map do |p|
        Program.new(C::Program.new(p))
      end
    end

    def metadata
      Dictionary.new(@ptr[:metadata])
    end

    def dump_format(index, url, is_output)
      C::AVFormat.av_dump_format(@ptr, index, url, is_output ? 1 : 0)
    end

    def find_best_stream(type, wanted_stream_nb = -1, related_stream = -1)
      r = C::AVFormat.av_find_best_stream(@ptr, type, wanted_stream_nb, related_stream, nil, 0)
      if r < 0
        raise Error.new(r)
      end
      streams[r]
    end
  end
end
