require 'ffi'

module FFmpegFFI
  module C
    class Rational < FFI::Struct
      layout(
        :num, :int,
        :den, :int,
      )

      def to_r
        Rational(self[:num], self[:den])
      end
    end
  end
end

