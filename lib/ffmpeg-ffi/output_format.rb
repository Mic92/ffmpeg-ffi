require 'ffmpeg-ffi/c'

module FFmpeg
  class OutputFormat
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def name
      @ptr[:name]
    end

    def long_name
      @ptr[:long_name]
    end

    Flags = FFI::Enum.new([
      :nofile, 0x0001,
      :neednumber, 0x0002,
      :show_ids, 0x0008,
      :rawpicture, 0x0020,
      :globalheader, 0x0040,
      :notimestamps, 0x0080,
      :generic_index, 0x0100,
      :ts_discont, 0x0200,
      :variable_fps, 0x0400,
      :nodimensions, 0x0800,
      :nostreams, 0x1000,
      :nobinsearch, 0x2000,
      :nogensearch, 0x4000,
      :no_byte_seek, 0x8000,
      :allow_flush, 0x10000,
      :ts_nonstrict, (FFmpeg.avformat_version[0] <= 54 ? 0x8020000 : 0x20000),
    ])
    def flags
      BitFlag.new(Flags, @ptr[:flags])
    end
    private :flags

    def globalheader?
      flags.has?(:globalheader)
    end

    def nofile?
      flags.has?(:nofile)
    end
  end
end
