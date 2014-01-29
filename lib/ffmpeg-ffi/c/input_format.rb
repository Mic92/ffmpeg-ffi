require 'ffi'

module FFmpeg
  module C
    class InputFormat < FFI::Struct
      layout(
        :name, :string,
        :long_name, :string,
        :flags, :int,
        :extensions, :string,
        :codec_tag, :pointer,
        :priv_class, :pointer,
        :next, InputFormat.by_ref,
        :raw_codec_id, :int,
        :priv_data_size, :int,
        :read_probe, :pointer,
        :read_header, :pointer,
        :read_packet, :pointer,
        :read_close, :pointer,
        :read_seek, :pointer,
        :read_timestamp, :pointer,
        :read_play, :pointer,
        :read_pause, :pointer,
        :read_seek2, :pointer,
      )
    end
  end
end
