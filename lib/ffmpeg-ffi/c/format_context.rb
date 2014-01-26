require 'ffmpeg-ffi/c/dictionary'
require 'ffmpeg-ffi/c/input_format'

module FFmpegFFI
  module C
    class FormatContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :iformat, InputFormat.by_ref,
        :oformat, :pointer,
        :priv_data, :pointer,
        :pb, :pointer,
        :ctx_flags, :int,
        :nb_streams, :int,
        :streams, :pointer,
        :filename, [:char, 1024],
        :start_time, :int64,
        :duration, :int64,
        :bit_rate, :int,
        :packet_size, :uint,
        :max_delay, :int,
        :flags, :int,
        :probesize, :uint,
        :max_analyze_duration, :int,
        :key, :pointer,
        :keylen, :int,
        :nb_programs, :uint,
        :programs, :pointer,
        :video_codec_id, :int,
        :audio_codec_id, :int,
        :subtitle_codec_id, :int,
        :max_index_size, :uint,
        :max_picture_buffer, :uint,
        :nb_chapters, :uint,
        :chapters, :pointer,
        :metadata, Dictionary.by_ref,
        # and more...
      )
    end
  end
end
