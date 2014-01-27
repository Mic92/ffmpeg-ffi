#!/usr/bin/env ruby
require 'ffmpeg-ffi'

def hd?(fname, n)
  ctx = FFmpeg::FormatContext.open_input(fname)
  ctx.pb.seek(n * 188, IO::SEEK_SET)
  ctx.find_stream_info

  ctx.streams.any? do |stream|
    codec_ctx = stream.codec
    next unless codec_ctx.codec_type_string == 'video'
    next unless codec_ctx.codec_name == 'mpeg2video'
    [codec_ctx.width, codec_ctx.height] == [1440, 1080]
  end
ensure
  ctx.close_input if ctx
end

def bsearch(fname, lo, hi, hi_is_hd)
  while lo < hi
    mid = (lo + hi)/2
    if hd?(fname, mid) == hi_is_hd
      hi = mid
    else
      lo = mid+1
    end
  end
  lo
end

MAX_PACKETS = 200000

def cleanup(infile, outfile)
  case [hd?(infile, 0), hd?(infile, MAX_PACKETS)]
  when [true, true], [false, false]
    do_clean(infile, outfile, 0)
  when [true, false]
    do_clean(infile, outfile, bsearch(infile, 0, MAX_PACKETS, false))
  when [false, true]
    do_clean(infile, outfile, bsearch(infile, 0, MAX_PACKETS, true))
  end
end

def build_command(infile)
  ['ffmpeg', '-loglevel', 'fatal', '-i', infile, '-acodec', 'copy', '-vcodec', 'copy']
end

def do_clean(infile, outfile, n)
  if n == 0
    cmd_ffmpeg = build_command(infile) + ['-ss', '0.5', '-y', outfile]
    puts cmd_ffmpeg.join(' ')
    system(*cmd_ffmpeg)
  else
    require 'open3'
    cmd_tail = ['tail', '-c', "+#{n*188}", infile]
    cmd_ffmpeg = build_command('-') + ['-y', outfile]
    puts cmd_tail.join(' ')
    puts cmd_ffmpeg.join(' ')
    Open3.pipeline(cmd_tail, cmd_ffmpeg)
  end
end

FFmpeg.log_level = FFmpeg::LOG_FATAL

infile = ARGV[0]
outfile = ARGV[1]
unless outfile
  puts "Usage: #{$0} infile outfile"
  exit 1
end

cleanup(infile, outfile)
