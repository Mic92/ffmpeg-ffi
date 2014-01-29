require 'ffmpeg-ffi'

module FFmpeg
  module Math
    module_function

    Rounding = FFI::Enum.new([
      :zero, 0,
      :inf, 1,
      :down, 2,
      :up, 3,
      :near_inf, 5,
      :pass_minmax, 8192,
    ], :rounding)

    def rescale(a, b, c, rounding = nil)
      if b.is_a?(Integer) && c.is_a?(Integer)
        if rounding
          C::AVUtil.av_rescale_rnd(a, b, c, BitFlag.new(Rounding, rounding).to_i)
        else
          C::AVUtil.av_rescale(a, b, c)
        end
      else
        b = C::Rational.from_r(b.to_r)
        c = C::Rational.from_r(c.to_r)
        if rounding
          C::AVUtil.av_rescale_q_rnd(a, b, c, BitFlag.new(Rounding, rounding).to_i)
        else
          C::AVUtil.av_rescale_q(a, b, c)
        end
      end
    end
  end
end
