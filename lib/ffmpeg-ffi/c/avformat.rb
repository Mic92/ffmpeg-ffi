require 'ffmpeg-ffi/c/codec'
require 'ffmpeg-ffi/c/format_context'
require 'ffmpeg-ffi/c/io_context'
require 'ffmpeg-ffi/c/packet'
require 'ffmpeg-ffi/c/stream'

module FFmpeg
  module C
    module AVFormat
      extend FFI::Library
      ffi_lib ['libavformat.so.55']

      enum :media_type, [
        :unknown, -1,
        :video,
        :audio,
        :data,
        :subtitle,
        :attachment,
        :nb,
      ]

      attach_function :av_register_all, [], :void
      attach_function :avformat_version, [], :uint
      attach_function :avformat_configuration, [], :string
      attach_function :avformat_license, [], :string

      attach_function :avformat_open_input, [:pointer, :string, :pointer, :pointer], :int
      attach_function :avformat_alloc_output_context2, [:pointer, :pointer, :string, :string], :int
      attach_function :avformat_close_input, [:pointer], :void
      attach_function :avformat_free_context, [FormatContext.by_ref], :void

      attach_function :avformat_find_stream_info, [FormatContext.by_ref, :pointer], :int
      attach_function :av_find_best_stream, [FormatContext.by_ref, :media_type, :int, :int, :pointer, :int], :int
      attach_function :av_dump_format, [FormatContext.by_ref, :int, :string, :int], :void

      attach_function :avio_open, [:pointer, :string, :int], :int
      attach_function :avio_seek, [IOContext.by_ref, :int64, :int], :int64
      attach_function :avio_close, [IOContext.by_ref], :int

      attach_function :avformat_new_stream, [FormatContext.by_ref, Codec.by_ref], Stream.by_ref

      attach_function :avformat_write_header, [FormatContext.by_ref, :pointer], :int
      attach_function :av_read_frame, [FormatContext.by_ref, :pointer], :int
      attach_function :av_interleaved_write_frame, [FormatContext.by_ref, Packet.by_ref], :int
      attach_function :av_write_trailer, [FormatContext.by_ref], :int
    end
  end
end
