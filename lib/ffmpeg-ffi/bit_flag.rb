module FFmpeg
  class BitFlag
    def initialize(enum, flags)
      @enum = enum
      @bits = from_flags(flags)
    end

    def from_flags(flags)
      Array(flags).map { |flag| flag.is_a?(Symbol) ? @enum[flag] : flag }.inject(0, :|)
    end
    private :from_flags

    def has?(flag)
      (@bits & @enum[flag]) != 0
    end

    def set(flag, v)
      flags = to_flags
      if v
        flags << flag
      else
        flags.delete(flag)
      end
      self.class.new(@enum, flags)
    end

    def to_i
      @bits
    end

    def to_flags
      @enum.symbols.select { |sym| has?(sym) }
    end
  end
end
