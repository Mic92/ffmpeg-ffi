require 'ffmpeg-ffi/c'

module FFmpeg
  class Codec
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

    def self.find_decoder(codec_id)
      ptr = C::AVCodec.avcodec_find_decoder(codec_id)
      unless ptr.null?
        new(ptr)
      end
    end
  end
end
