require 'ffi'

module FFmpeg
  module C
    class Rational < FFI::Struct
      layout(
        :num, :int,
        :den, :int,
      )

      def to_r
        Rational(self[:num], self[:den])
      end

      def self.from_r(r)
        c = C::Rational.new
        c[:num] = r.numerator
        c[:den] = r.denominator
        c
      end
    end
  end
end

