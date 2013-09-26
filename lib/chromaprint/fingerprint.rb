module Chromaprint
  # Contains compressed and raw fingerprints and provides a method to compare
  # them against other fingerprints.
  class Fingerprint
    # Number of bits in one item of raw fingerprint
    BITS_PER_RAW_ITEM = 32

    # @attr_reader compressed [String] compressed fingerprints
    attr_reader :compressed

    # @attr_reader raw [Array<Integer>] raw fingerprints,
    #   array of 32-bit integers returned by native C library.
    attr_reader :raw

    # @param compressed [String] compressed fingerprint
    # @param raw [Array<Integer>] raw fingerprint
    def initialize(compressed, raw)
      @compressed = compressed
      @raw        = raw
    end

    # Compare a fingerprint against another fingerprint.
    #
    # @param fingerprint [Chromaprint::Fingerprint] fingerprint to compare against
    #
    # @return [Float] float in 0..1 range where 1 is 100% match
    def compare(fingerprint)
      max_raw_size = [@raw.size, fingerprint.raw.size].max
      bit_size     = max_raw_size * BITS_PER_RAW_ITEM

      distance     = hamming_distance(@raw, fingerprint.raw)

      1 - distance.to_f / bit_size
    end

    # Calculate hamming distance between 32 bit integer arrays.
    # In short we're calculating number of bits which are different.
    #
    # Read more: http://en.wikipedia.org/wiki/Hamming_distance
    #
    # It's sad to say but according to Stackoverflow it's the fastest
    # way to calculate hamming distance between 2 integers in ruby:
    #   (a^b).to_s(2).count("1")
    #
    # If array sizes are different we add difference to the distance.
    #
    # @param raw1 [Array<Integer>] array of 32 bit integers.
    # @param raw2 [Array<Integer>] array of 32 bit integers.
    #
    # @return [Integer] hamming distance
    def hamming_distance(raw1, raw2)
      distance = 0

      min_size, max_size = [raw1, raw2].map(&:size).sort

      min_size.times do |i|
        distance += (raw1[i] ^ raw2[i]).to_s(2).count('1')
      end

      distance += (max_size - min_size) * BITS_PER_RAW_ITEM
    end
    private :hamming_distance
  end
end
