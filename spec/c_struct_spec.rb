require 'spec_helper'
require 'ffmpeg-ffi/c'
require 'open3'
require 'tmpdir'

shared_examples_for 'a C struct' do
  let(:c_name) { "AV#{described_class.name[/[^:]+\z/]}" }

  it 'has correct size' do
    real_size = gcc(<<-"EOS")
printf("%zu\\n", sizeof(#{c_name}));
return 0;
    EOS
    expect(described_class.size).to eq(real_size.strip.to_i)
  end

  it 'has correct members' do
    code = ["#{c_name} s;"]
    described_class.members.each do |field|
      code << %Q{printf("#{field}=%zu\\n", sizeof(s.#{field}));}
    end
    code << "return 0;"

    expected_sizes = described_class.members.map do |field|
      "#{field}=#{described_class.layout[field].size}"
    end
    expect(gcc(code.join("\n")).each_line.map(&:chomp)).to eq(expected_sizes)
  end

  def gcc(code)
    libs = %w[libavcodec libavformat libavutil]
    program = libs.map { |lib| "#include <#{lib}/#{lib[3 .. -1]}.h>" }
    extra_headers = %w[libavutil/dict.h]
    program += extra_headers.map { |h| "#include <#{h}>" }
    program << 'int main(void) {' << code << '}'

    o, e, s = Open3.capture3('pkg-config', '--cflags', '--libs', *libs)
    unless s.exited? && s.exitstatus == 0
      $stderr.puts o.inspect
      $stderr.puts e.inspect
      raise "pkg-config failed"
    end
    opts = o.strip.split(/\s+/)

    Dir.mktmpdir do |dir|
      path = File.join(dir, 'sizecheck')
      o, e, s = Open3.capture3('gcc', '-xc', '-', '-o', path, *opts, stdin_data: program.join("\n"))
      unless s.exited? && s.exitstatus == 0
        $stderr.puts o.inspect
        $stderr.puts e.inspect
        $stderr.puts program
        raise "gcc failed"
      end

      o, e, s = Open3.capture3(path)
      unless s.exited? && s.exitstatus == 0
        $stderr.puts o.inspect
        $stderr.puts e.inspect
        raise "execution failed"
      end
      o
    end
  end
end

module FFmpeg::C
  describe 'C struct' do
    describe Codec do
      it_behaves_like 'a C struct'
    end

    describe CodecContext do
      it_behaves_like 'a C struct'
    end

    describe DictionaryEntry do
      it_behaves_like 'a C struct'
    end

    describe FormatContext do
      it_behaves_like 'a C struct'
    end

    describe Frac do
      it_behaves_like 'a C struct'
    end

    describe IOContext do
      it_behaves_like 'a C struct'
    end

    describe IOInterruptCB do
      it_behaves_like 'a C struct'
    end

    describe InputFormat do
      it_behaves_like 'a C struct'
    end

    describe OutputFormat do
      it_behaves_like 'a C struct'
    end

    describe Packet do
      it_behaves_like 'a C struct'
    end

    describe ProbeData do
      it_behaves_like 'a C struct'
    end

    describe Program do
      it_behaves_like 'a C struct'
    end

    describe Rational do
      it_behaves_like 'a C struct'
    end

    describe Stream do
      it_behaves_like 'a C struct'
    end
  end
end
