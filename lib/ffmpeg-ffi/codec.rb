require 'ffmpeg-ffi/c'

module FFmpeg
  class Codec
    include StructCommon
    field_accessor :name, :long_name

    def self.find_decoder(codec_id)
      ptr = C::AVCodec.avcodec_find_decoder(codec_id)
      unless ptr.null?
        new(ptr)
      end
    end

    def profile_name(profile)
      C::AVCodec.av_get_profile_name(@ptr, profile)
    end
  end
end
