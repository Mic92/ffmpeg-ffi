module FFmpeg
  class InputFormat
    include StructCommon
    field_accessor :name, :long_name, :extensions
  end
end
