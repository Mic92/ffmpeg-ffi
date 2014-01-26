require 'ffi'

module FFmpegFFI
  module C
    class Program < FFI::Struct
      layout(
        :id, :int,
        :flags, :int,
        :discard, :int,
        :stream_index, :pointer,
        :nb_stream_indexes, :uint,
        :metadata, :pointer,
        :program_num, :int,
        :pmt_pid, :int,
        :pcr_pid, :int,
        :start_time, :int64,
        :end_time, :int64,
        :pts_wrap_reference, :int64,
        :pts_wrap_behavior, :int,
      )
    end
  end
end
