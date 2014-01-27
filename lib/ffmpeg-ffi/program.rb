require 'ffmpeg-ffi'

module FFmpeg
  class Program
    attr_reader :ptr

    def initialize(ptr)
      @ptr = ptr
    end

    def id
      @ptr[:id]
    end

    def stream_indexes
      @ptr[:stream_index].read_array_of_type(:uint, :read_uint, nb_stream_indexes)
    end

    def nb_stream_indexes
      @ptr[:nb_stream_indexes]
    end

    def metadata
      Dictionary.new(@ptr[:metadata])
    end

    def program_num
      @ptr[:program_num]
    end

    def pmt_pid
      @ptr[:pmt_pid]
    end

    def pcr_pid
      @ptr[:pcr_pid]
    end
  end
end
