require "ffmpeg-ffi/version"

module FFmpeg
  autoload :Codec, 'ffmpeg-ffi/codec'
  autoload :CodecContext, 'ffmpeg-ffi/codec_context'
  autoload :Dictionary, 'ffmpeg-ffi/dictionary'
  autoload :DictionaryEntry, 'ffmpeg-ffi/dictionary_entry'
  autoload :Error, 'ffmpeg-ffi/error'
  autoload :FormatContext, 'ffmpeg-ffi/format_context'
  autoload :IOContext, 'ffmpeg-ffi/io_context'
  autoload :InputFormat, 'ffmpeg-ffi/input_format'
  autoload :OutputFormat, 'ffmpeg-ffi/output_format'
  autoload :Packet, 'ffmpeg-ffi/packet'
  autoload :Program, 'ffmpeg-ffi/program'
  autoload :Stream, 'ffmpeg-ffi/stream'

  LOG_QUIET = -8
  LOG_PANIC = 0
  LOG_FATAL = 8
  LOG_ERROR = 16
  LOG_WARNING = 24
  LOG_INFO = 32
  LOG_VERBOSE = 40
  LOG_DEBUG = 48

  module ClassMethods
    def log_level
      C::AVUtil.av_log_get_level
    end

    def log_level=(level)
      C::AVUtil.av_log_set_level(level)
    end

    def avcodec_version
      split_version(C::AVCodec.avcodec_version)
    end

    def avcodec_configuration
      C::AVCodec.avcodec_configuration
    end

    def avcodec_license
      C::AVCodec.avcodec_license
    end

    def avformat_version
      split_version(C::AVFormat.avformat_version)
    end

    def avformat_configuration
      C::AVFormat.avformat_configuration
    end

    def avformat_license
      C::AVFormat.avformat_license
    end

    def avutil_version
      split_version(C::AVUtil.avutil_version)
    end

    def avutil_configuration
      C::AVUtil.avutil_configuration
    end

    def avutil_license
      C::AVUtil.avutil_license
    end

    private

    def split_version(version)
      [version >> 16, (version >> 8) & 0xff, version & 0xff]
    end
  end
  extend ClassMethods
end

require 'ffmpeg-ffi/c'
