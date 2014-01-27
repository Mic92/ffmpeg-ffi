#!/usr/bin/env ruby
require 'ffmpeg-ffi'

infile = ARGV[0]
outfile = ARGV[1]
unless outfile
  puts "Usage: #{$0} input output"
  exit 1
end

iformat_ctx = FFmpeg::FormatContext.open_input(infile)
iformat_ctx.find_stream_info

oformat_ctx = FFmpeg::FormatContext.alloc_output(nil, nil, outfile)
oformat = oformat_ctx.oformat
p oformat.nofile?

iformat_ctx.close_input
oformat_ctx.free
