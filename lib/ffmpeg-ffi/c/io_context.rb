require 'ffi'

module FFmpeg
  module C
    class IOContext < FFI::Struct
      layout(
        :av_class, :pointer,
        :buffer, :pointer,
        :buffer_size, :int,
        :buf_ptr, :pointer,
        :buf_end, :pointer,
        :opaque, :pointer,
        :read_packet, :pointer,
        :write_packet, :pointer,
        :seek, :pointer,
        :pos, :int64,
        :must_flush, :int,
        :eof_reached, :int,
        :write_flag, :int,
        :max_packet_size, :int,
        :checksum, :ulong,
        :checksum_ptr, :pointer,
        :update_checksum, :pointer,
        :error, :int,
        :read_pause, :pointer,
        :read_seek, :pointer,
        :seekable, :int,
        :maxsize, :int64,
        :direct, :int,
        :bytes_read, :int64,
        :seek_count, :int,
        :writeout_count, :int,
      )
    end
  end
end
