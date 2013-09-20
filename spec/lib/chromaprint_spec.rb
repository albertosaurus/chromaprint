require 'spec_helper'

describe Chromaprint do
  describe '.lib_version' do
    it 'should delegate to Lib.chromaprint_get_version' do
      Chromaprint::Lib.should_receive(:chromaprint_get_version)
      Chromaprint.lib_version
    end

    it 'should return sting' do
      Chromaprint.lib_version.should be_a String
    end
  end
end
