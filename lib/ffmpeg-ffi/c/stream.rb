require 'ffmpeg-ffi/c/codec_context'
require 'ffmpeg-ffi/c/dictionary'
require 'ffmpeg-ffi/c/frac'
require 'ffmpeg-ffi/c/packet'
require 'ffmpeg-ffi/c/rational'

module FFmpeg
  module C
    class Stream < FFI::Struct
      MAX_REORDER_DELAY = 16

      fields = [
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
        :avg_frame_rate, Rational.by_value,
        :attached_pic, Packet.by_value,
        :info, :pointer,
        :pts_wrap_bits, :int,
        :reference_dts, :int64,
        :first_dts, :int64,
        :cur_dts, :int64,
        :last_IP_pts, :int64,
        :last_IP_duration, :int,
        :probe_packets, :int,
        :codec_info_nb_frames, :int,
        :need_parsing, :int,
        :parser, :pointer,
        :last_in_packet_buffer, :pointer,
        :probe_data, ProbeData.by_value,
        :pts_buffer, [:int64, MAX_REORDER_DELAY+1],
        :index_entries, :pointer,
        :nb_index_entries, :int,
        :index_entries_allocated_size, :uint,
        :r_frame_rate, Rational.by_value,
        :stream_identifier, :int,
        :interleaver_chunk_size, :int64,
        :interleaver_chunk_duration, :int64,
        :request_probe, :int,
        :skip_to_keyframe, :int,
        :skip_samples, :int,
        :nb_decoded_frames, :int,
        :mux_ts_offset, :int64,
        :pts_wrap_reference, :int64,
        :pts_wrap_behavior, :int,
      ]

      layout(*fields)
    end
  end
end
