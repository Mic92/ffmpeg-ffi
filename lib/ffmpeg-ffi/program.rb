require 'ffmpeg-ffi'

module FFmpeg
  class Program
    include StructCommon
    field_accessor :id, :program_num, :pmt_pid, :pcr_pid

    def stream_indexes
      @ptr[:stream_index].read_array_of_type(:uint, :read_uint, nb_stream_indexes)
    end

    def nb_stream_indexes
      @ptr[:nb_stream_indexes]
    end

    def metadata
      Dictionary.new(@ptr[:metadata])
    end
  end
end
