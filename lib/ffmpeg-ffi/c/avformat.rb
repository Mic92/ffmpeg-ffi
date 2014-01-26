require 'ffmpeg-ffi/c/format_context'

module FFmpegFFI
  module C
    module AVFormat
      extend FFI::Library
      ffi_lib ['libavformat.so.55']

      attach_function :av_register_all, [], :void
      attach_function :avformat_open_input, [:pointer, :string, :pointer, :pointer], :int
      attach_function :avformat_close_input, [:pointer], :void
      attach_function :avformat_find_stream_info, [FormatContext.by_ref, :pointer], :int
      attach_function :av_dump_format, [FormatContext.by_ref, :int, :string, :int], :void
    end
  end
end
