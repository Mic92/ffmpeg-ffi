#!/usr/bin/env ruby
require 'ffmpeg-ffi'

def dump_metadata(metadata, indent)
  metadata.each_entry('', :ignore_suffix) do |entry|
    puts "#{' ' * indent}#{entry.key}: #{entry.value.inspect}"
  end
end

def dump_stream(i, stream)
  puts "    Stream ##{i}:#{stream.index}[0x#{stream.id.to_s(16)}] #{stream.codec.string(false)}"
  codec_ctx = stream.codec
  codec = codec_ctx.codec || FFmpeg::Codec.find_decoder(codec_ctx.codec_id)
  profile_name = codec ? codec.profile_name(codec_ctx.profile) : codec_ctx.profile
  puts "    Stream ##{i}:#{stream.index}[0x#{stream.id.to_s(16)}] #{codec_ctx.media_type_string || 'unknown'}: #{codec_ctx.codec_name} (#{profile_name})"
  if stream.metadata.count > 0
    puts "    Metadata:"
    dump_metadata(stream.metadata, 6)
  end
end

%w[avcodec avformat avutil].each do |s|
  puts "#{s}: #{FFmpeg.send("#{s}_version").join('.')}: #{FFmpeg.send("#{s}_license")}"
  puts "  #{FFmpeg.send("#{s}_configuration")}"
end

ARGV.each_with_index do |arg, i|
  ctx = FFmpeg::FormatContext.open_input(arg)
  ctx.find_stream_info

  puts "#{ctx.iformat.name} (#{ctx.iformat.long_name}) from #{ctx.filename}"
  if ctx.metadata.count > 0
    puts "  Metadata:"
    dump_metadata(ctx.metadata, 4)
  end
  puts "  Duration: #{ctx.duration.to_f}, start: #{ctx.start_time.to_f.abs}, bitrate: #{ctx.bit_rate / 1000.0} kb/s"

  printed = {}

  ctx.programs.each do |program|
    puts "  Program #{program.id} (program_num #{program.program_num}, pmt_pid #{program.pmt_pid}, pcr_pid #{program.pcr_pid})"
    if program.metadata.count > 0
      puts "  Metadata:"
      dump_metadata(program.metadata, 4)
    end

    program.stream_indexes.each do |stream_id|
      dump_stream(i, ctx.streams[stream_id])
      printed[stream_id] = true
    end
  end

  ctx.streams.each do |stream|
    dump_stream(i, stream) unless printed[stream.index]
  end

  video_stream = ctx.find_best_stream(:video)
  audio_stream = ctx.find_best_stream(:audio)
  puts "  Best video stream: #{video_stream.index}[0x#{video_stream.id.to_s(16)}]"
  puts "  Best audio stream: #{audio_stream.index}[0x#{audio_stream.id.to_s(16)}]"

  ctx.close_input
end
