require 'spec_helper'

describe Chromaprint::Fingerprint do
  describe '#new' do
    it 'should set compressed and raw' do
      fingerprint = described_class.new('AAAQ', [13, 15])
      fingerprint.compressed.should == 'AAAQ'
      fingerprint.raw.should == [13, 15]
    end
  end

  describe '#compare' do
    context 'raw fingerprint are the same' do
      it 'should return 1' do
        fp1 = described_class.new('', [1, 2])
        fp2 = described_class.new('', [1, 2])
        fp1.compare(fp2).should == 1
      end
    end

    context 'raw fingerprint are 100% different' do
      it 'should return 0' do
        fp1 = described_class.new('', [0xFFFFFFFF, 0x0])
        fp2 = described_class.new('', [0x0, 0xFFFFFFFF])
        fp1.compare(fp2).should == 0
      end
    end

    context 'quarter of the fingerprint matches' do
      it 'should return 0.25' do
        fp1 = described_class.new('', [0x0F0F0F0F, 0xF0F0FFFF])
        fp2 = described_class.new('', [0xF0F0F0F0, 0xF0F00000])
        fp1.compare(fp2).should == 0.25
      end
    end
  end

  describe '#hamming_distance' do
    let(:fingerprint) { described_class.new('', []) }

    context 'raws have same size' do
      it 'should calculate hamming distance' do
        #  00010001
        #  00001110
        fingerprint.send(:hamming_distance, [17], [14]).should == 5

        #  00000001  11111111
        #  00000000  10000000
        fingerprint.send(:hamming_distance, [511], [128]).should == 8

        fingerprint.send(:hamming_distance, [511, 17], [128, 14]).should == 13
      end
    end

    context 'raws have different size' do
      it 'should calculate hamming distance and add size difference to it' do
        #  00010001  xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx
        #  00001110  000000000 000000000 000000000 000000001
        fingerprint.send(:hamming_distance, [17], [14, 1]).should == 37
      end
    end
  end
end
