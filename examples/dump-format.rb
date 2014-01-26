#!/usr/bin/env ruby
require 'ffmpeg-ffi'

ARGV.each_with_index do |arg, i|
  ctx = FFmpegFFI::FormatContext.open_input(arg)
  ctx.find_stream_info
  ctx.dump_format(i, arg, false)

  puts "#{ctx.iformat.name} (#{ctx.iformat.long_name}) from #{ctx.filename}"
  puts "  Duration: #{ctx.duration.to_f}, start: #{ctx.start_time.to_f.abs}, bitrate: #{ctx.bit_rate / 1000.0} kb/s"

  ctx.streams.each do |stream|
    puts "    Stream ##{i}:#{stream.index}[0x#{stream.id.to_s(16)}]"
  end

  video_stream = ctx.find_best_stream(:video)
  audio_stream = ctx.find_best_stream(:audio)
  puts "  Best video stream: #{video_stream.index}[0x#{video_stream.id.to_s(16)}]"
  puts "  Best audio stream: #{audio_stream.index}[0x#{audio_stream.id.to_s(16)}]"

  ctx.close_input
end
