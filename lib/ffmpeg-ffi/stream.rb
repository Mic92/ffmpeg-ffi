require 'ffmpeg-ffi'

module FFmpeg
  class Stream
    include StructCommon
    field_accessor :index, :id

    def codec
      CodecContext.new(@ptr[:codec])
    end

    def time_base
      @ptr[:time_base].to_r
    end

    def metadata
      Dictionary.new(@ptr[:metadata])
    end
  end
end
