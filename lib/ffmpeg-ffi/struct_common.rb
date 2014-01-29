require 'ffmpeg-ffi/error'

module FFmpeg
  module StructCommon
    def self.included(base)
      base.class_eval do
        attr_reader :ptr
      end
      base.extend ClassMethods
    end

    def initialize(ptr)
      @ptr = ptr
    end

    def raise_averror(&block)
      self.class.raise_averror(&block)
    end

    def to_h
      @ptr.to_h
    end

    def to_hash
      @ptr.to_hash
    end

    module ClassMethods
      def field_accessor(*fields)
        fields.each do |field|
          define_method(field) do
            @ptr[field]
          end
          define_method("#{field}=") do |v|
            @ptr[field] = v
          end
        end
      end

      def raise_averror(&block)
        r = block.call
        if r < 0
          raise Error.new(r)
        else
          r
        end
      end
    end
  end
end
