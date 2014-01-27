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

def cleanup(fname)
  case [hd?(fname, 0), hd?(fname, MAX_PACKETS)]
  when [true, true], [false, false]
    do_clean(fname, 0)
  when [true, false]
    do_clean(fname, bsearch(fname, 0, MAX_PACKETS, false))
  when [false, true]
    do_clean(fname, bsearch(fname, 0, MAX_PACKETS, true))
  end
end

def do_clean(fname, n)
  gap = ''
  if n == 0
    gap = '-ss 0.5'
  end
  puts "tail -c +#{n*188} #{fname} | ffmpeg -i - -acodec copy -vcodec copy #{gap} -y out.ts"
end

FFmpeg.log_level = FFmpeg::LOG_FATAL

ARGV.each do |arg|
  cleanup(arg)
end
