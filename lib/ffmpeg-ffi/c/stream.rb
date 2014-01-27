require 'ffmpeg-ffi/c/codec_context'
require 'ffmpeg-ffi/c/dictionary'
require 'ffmpeg-ffi/c/frac'
require 'ffmpeg-ffi/c/rational'

module FFmpeg
  module C
    class Stream < FFI::Struct
      layout(
        :index, :int,
        :id, :int,
        :codec, CodecContext.by_ref,
        :priv_data, :pointer,
        :pts, Frac.by_value,
        :time_base, Rational.by_value,
        :start_time, :int64,
        :duration, :int64,
        :nb_frames, :int64,
        :disposition, :int,
        :discard, :int,
        :sample_aspect_ratio, Rational.by_value,
        :metadata, Dictionary.by_ref,
        # and more
      )
    end
  end
end
