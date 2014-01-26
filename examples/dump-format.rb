#!/usr/bin/env ruby
require 'ffmpeg-ffi'

ARGV.each_with_index do |arg, i|
  ctx = FFmpegFFI::FormatContext.open_input(arg)
  ctx.find_stream_info
  ctx.dump_format(i, arg, false)
  p ctx.close_input
end
