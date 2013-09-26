require 'spec_helper'

describe 'Chromaprint integration' do
  # Path to directory with file fixtures
  FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

  # Get absolute path to fixture file by its name
  #
  # @param filename [String]
  #
  # @return [String] path
  def fixture(filename)
    File.join(FIXTURES_PATH, filename)
  end

  let(:rate)     { 22050 }
  let(:channels) { 1     }

  it 'should compare fingerprints' do
    data_a = File.binread(fixture('a.wav'))
    data_b = File.binread(fixture('b.wav'))

    chromaprint = Chromaprint::Context.new(rate, channels)

    fp_a = chromaprint.get_fingerprint(data_a)
    fp_b = chromaprint.get_fingerprint(data_b)

    fp_a.compare(fp_b).should be_within(0.005).of(0.995)
  end
end
