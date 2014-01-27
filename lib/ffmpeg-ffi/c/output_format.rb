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
        # and more...
      )
    end
  end
end
