require 'ffmpeg-ffi'

module FFmpeg
  module C
    FF_API_DESTRUCT_PACKET = FFmpeg.avcodec_version[0] < 56

    class Packet < FFI::Struct
      fields = [
        :buf, :pointer,
        :pts, :int64,
        :dts, :int64,
        :data, :pointer,
        :size, :int,
        :stream_index, :int,
        :flags, :int,
        :side_data, :pointer,
        :side_data_elems, :int,
        :duration, :int,
      ]
      if FF_API_DESTRUCT_PACKET
        fields += [
          :destruct, :pointer,
          :priv, :pointer,
        ]
      end
      fields += [
        :pos, :int64,
        :convergence_duration, :int64,
      ]

      layout(*fields)
    end
  end
end
