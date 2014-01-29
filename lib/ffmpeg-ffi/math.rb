require 'ffmpeg-ffi'

module FFmpeg
  module Math
    module_function

    def rescale(a, b, c, rounding = nil)
      if b.is_a?(Integer) && c.is_a?(Integer)
        if rounding
          C::AVUtil.av_rescale_rnd(a, b, c, from_flags(C::AVUtil::Rounding, rounding))
        else
          C::AVUtil.av_rescale(a, b, c)
        end
      else
        b = C::Rational.from_r(b.to_r)
        c = C::Rational.from_r(c.to_r)
        if rounding
          C::AVUtil.av_rescale_q_rnd(a, b, c, from_flags(C::AVUtil::Rounding, rounding))
        else
          C::AVUtil.av_rescale_q(a, b, c)
        end
      end
    end

    def from_flags(enum, flags)
      Array(flags).map { |flag| flag.is_a?(Symbol) ? enum[flag] : flag }.inject(0, :|)
    end
  end
end
