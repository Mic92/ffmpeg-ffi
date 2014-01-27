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
iformat_ctx.streams.each do |in_stream|
  out_stream = oformat_ctx.new_stream(in_stream.codec.codec);
  out_stream.codec.copy_from(in_stream.codec)
  if oformat_ctx.oformat.globalheader?
    out_stream.codec.global_header = true
  end
  p out_stream.codec.ptr.to_hash
end

iformat_ctx.close_input
oformat_ctx.free
