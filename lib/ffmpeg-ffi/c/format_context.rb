require 'ffmpeg-ffi/c/dictionary'
require 'ffmpeg-ffi/c/codec'
require 'ffmpeg-ffi/c/input_format'
require 'ffmpeg-ffi/c/output_format'
require 'ffmpeg-ffi/c/io_context'

module FFmpeg
  module C
    class FormatContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :iformat, InputFormat.by_ref,
        :oformat, OutputFormat.by_ref,
        :priv_data, :pointer,
        :pb, IOContext.by_ref,
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
        :start_time_realtime, :int64,
        :fps_probe_size, :int,
        :error_recognition, :int,
        :interrupt_callback, IOInterruptCB.by_value,
        :debug, :int,
        :ts_id, :int,
        :audio_preload, :int,
        :max_chunk_duration, :int,
        :max_chunk_size, :int,
        :use_wallclock_as_timestamps, :int,
        :avoid_negative_ts, :int,
        :avio_flags, :int,
        :duration_estimation_method, :int,
        :skip_initial_bytes, :uint,
        :correct_ts_overflow, :uint,
        :seek2any, :int,
        :flush_packets, :int,
        :probe_score, :int,
        :packet_buffer, :pointer,
        :packet_buffer_end, :pointer,
        :data_offset, :int64,
        :raw_packet_buffer, :pointer,
        :raw_packet_buffer_end, :pointer,
        :parse_queue, :pointer,
        :parse_queue_end, :pointer,
        :raw_packet_buffer_remaining_size, :int,
        :offset, :int64,
        :offset_timebase, Rational.by_value,
        :io_repositioned, :int,
        :video_codec, Codec.by_ref,
        :audio_codec, Codec.by_ref,
        :subtitle_codec, Codec.by_ref,
        # and more...
      )
    end
  end
end
