require 'ffmpeg-ffi'

module FFmpeg
  module C
    class Codec < FFI::Struct
      FF_API_LOWRES = FFmpeg.avcodec_version[0] < 56

      fields = [
        :name, :string,
        :long_name, :string,
        :type, :int,
        :id, :int,
        :capabilities, :int,
        :supported_framerates, Rational.by_ref,
        :pix_fmts, :pointer,
        :supported_samplerates, :pointer,
        :sample_fmts, :pointer,
        :channel_layouts, :uint64,
      ]
      if FF_API_LOWRES
        fields += [:max_lowres, :uint8]
      end
      fields += [
        :priv_class, :pointer,
        :profiles, :pointer,
        :priv_data_size, :int,
        :next, Codec.by_ref,
        :init_thread_copy, :pointer,
        :update_thread_context, :pointer,
        :defaults, :pointer,
        :init_static_data, :pointer,
        :init, :pointer,
        :encode_sub, :pointer,
        :encode2, :pointer,
        :decode, :pointer,
        :close, :pointer,
        :flush, :pointer,
      ]
      layout(*fields)
    end
  end
end
