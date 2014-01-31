#!/usr/bin/env ruby
require 'ffmpeg-ffi'

HD_WIDTH = 1440
SD_WIDTH = 720

def hd_and_sd(ctx)
  has_hd, has_sd = false, false
  ctx.streams.each do |stream|
    codec_ctx = stream.codec
    next unless codec_ctx.media_type_string == 'video'
    next unless codec_ctx.codec_name == 'mpeg2video'
    has_hd = has_hd || codec_ctx.width == HD_WIDTH
    has_sd = has_sd || codec_ctx.width == SD_WIDTH
  end
  [has_hd, has_sd]
end

def has_stray_audio?(ctx)
  # When an audio stream is found outside the programs, ffmpeg seems to fail
  # with the following error message.
  #
  # [mpegts @ 0x???????] AAC bitstream not in ADTS format and extradata missing
  # av_interleaved_write_frame(): Invalid data found when processing input
  #
  # We have to avoid this kind of error.

  found_streams = {}
  ctx.programs.each do |program|
    video, audio = 0, 0
    program.stream_indexes.each do |index|
      found_streams[index] = true
    end
  end

  ctx.streams.any? do |stream|
    !found_streams.has_key?(stream.index) && stream.codec.media_type_string == 'audio'
  end
end

def with_format_context(fname, n, &block)
  ctx = FFmpeg::FormatContext.open_input(fname)
  ctx.pb.seek(n * 188, IO::SEEK_SET)
  ctx.find_stream_info
  block.call(ctx)
ensure
  ctx.close_input if ctx
end

def hd?(fname, n)
  with_format_context(fname, n) do |ctx|
    hd_and_sd(ctx)[0]
  end
end

def higher?(fname, n, hi_is_hd)
  with_format_context(fname, n) do |ctx|
    if has_stray_audio?(ctx)
      $stderr.puts "#{fname}: Stray audio is found at #{n}*188"
      return true
    end

    case hd_and_sd(ctx)
    when [true, true]
      # If both are found, proper cutpoint is higher.
      true
    when [true, false]
      !hi_is_hd
    when [false, true]
      hi_is_hd
    else
      raise "#{fname}: Neither HD nor SD at #{mid}"
    end
  end
end

def bsearch(fname, lo, hi, hi_is_hd)
  while lo < hi
    mid = (lo + hi)/2
    if higher?(fname, mid, hi_is_hd)
      lo = mid+1
    else
      hi = mid
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
    iformat_ctx = FFmpeg::FormatContext.open_input(infile)
    iformat_ctx.pb.seek(n*188, IO::SEEK_SET)
    iformat_ctx.find_stream_info

    # TODO: Need more precise guess.
    in_video = iformat_ctx.find_best_stream(:video)
    in_audio = iformat_ctx.find_best_stream(:audio)

    oformat_ctx = FFmpeg::FormatContext.alloc_output(nil, nil, outfile)
    out_video = oformat_ctx.new_stream(in_video.codec.codec)
    out_audio = oformat_ctx.new_stream(in_audio.codec.codec)
    out_video.codec.copy_from(in_video.codec)
    out_audio.codec.copy_from(in_audio.codec)
    if oformat_ctx.oformat.globalheader?
      out_video.codec.global_header = true
      out_audio.codec.global_header = true
    end

    stream_map = {
      in_video.index => out_video,
      in_audio.index => out_audio,
    }

    unless oformat_ctx.oformat.nofile?
      oformat_ctx.pb = FFmpeg::IOContext.open(outfile, FFmpeg::IOContext::WRITE)
    end

    oformat_ctx.write_header
    while packet = iformat_ctx.read_frame
      in_stream = iformat_ctx.streams[packet.stream_index]
      out_stream = stream_map[in_stream.index]
      if out_stream
        packet.stream_index = out_stream.index
        packet.pts = FFmpeg::Math.rescale(packet.pts, in_stream.time_base, out_stream.time_base, [:near_inf, :pass_minmax])
        packet.dts = FFmpeg::Math.rescale(packet.dts, in_stream.time_base, out_stream.time_base, [:near_inf, :pass_minmax])
        packet.duration = FFmpeg::Math.rescale(packet.duration, in_stream.time_base, out_stream.time_base)
        packet.pos = -1
        oformat_ctx.interleaved_write_frame(packet)
      end
      packet.free
    end
    oformat_ctx.write_trailer
  end
ensure
  if iformat_ctx
    iformat_ctx.close_input
  end
  if oformat_ctx
    unless oformat_ctx.oformat.nofile?
      oformat_ctx.pb.close
    end
    oformat_ctx.free
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
