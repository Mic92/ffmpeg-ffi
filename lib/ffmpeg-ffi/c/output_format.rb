module FFmpeg
  module C
    class OutputFormat < FFI::Struct
      layout(
        :name, :string,
        :long_name, :string,
        :mime_type, :string,
        :extensions, :string,
        :audio_codec, :int,
        :video_codec, :int,
        :subtitle_codec, :int,
        :flags, :int,
        :codec_tag, :pointer,
        :priv_class, :pointer,
        :next, OutputFormat.by_ref,
        :priv_data_size, :int,
        :write_header, :pointer,
        :write_packet, :pointer,
        :write_trailer, :pointer,
        :interleave_packet, :pointer,
        :query_codec, :pointer,
        :get_output_timestamp, :pointer,
      )
    end
  end
end
