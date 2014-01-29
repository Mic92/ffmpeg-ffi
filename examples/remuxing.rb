#!/usr/bin/env ruby
require 'ffmpeg-ffi'

# This example is a port of doc/examples/remuxing.c in FFmpeg.

infile = ARGV[0]
outfile = ARGV[1]
unless outfile
  puts "Usage: #{$0} input output"
  exit 1
end

def log_packet(format_ctx, packet, tag)
  time_base = format_ctx.streams[packet.stream_index].time_base
  printf(
    "%s: pts:%d pts_time:%.6f dts:%d dts_time:%.6f duration:%d duration_time:%.6f stream_index:%d\n",
    tag,
    packet.pts,
    packet.pts * time_base,
    packet.dts,
    packet.dts * time_base,
    packet.duration,
    packet.duration * time_base,
    packet.stream_index,
  )
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
end

unless oformat_ctx.oformat.nofile?
  oformat_ctx.pb = FFmpeg::IOContext.open(outfile, FFmpeg::IOContext::WRITE)
end

oformat_ctx.write_header

while pkt = iformat_ctx.read_frame
  log_packet(iformat_ctx, pkt, :in)

  in_stream = iformat_ctx.streams[pkt.stream_index]
  out_stream = oformat_ctx.streams[pkt.stream_index]

  pkt.pts = FFmpeg::Math.rescale(pkt.pts, in_stream.time_base, out_stream.time_base, [:near_inf, :pass_minmax])
  pkt.dts = FFmpeg::Math.rescale(pkt.dts, in_stream.time_base, out_stream.time_base, [:near_inf, :pass_minmax])
  pkt.duration = FFmpeg::Math.rescale(pkt.duration, in_stream.time_base, out_stream.time_base)
  pkt.pos = -1
  log_packet(oformat_ctx, pkt, :out)

  oformat_ctx.interleaved_write_frame(pkt)
  pkt.free
end

oformat_ctx.write_trailer

unless oformat_ctx.oformat.nofile?
  oformat_ctx.pb.close
end

iformat_ctx.close_input
oformat_ctx.free
