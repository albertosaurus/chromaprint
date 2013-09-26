require 'ffi'

require 'chromaprint/lib'
require 'chromaprint/context'
require 'chromaprint/fingerprint'

# Chromaprint is originally written in C/C++, a library which provides tools
# to calculate fingerprints of audio data. This is its port for the Ruby language.
module Chromaprint
  # All algorithm constants are taken from +chromaprint.h+
  ALGORITHM_TEST1 = 0

  # :nodoc:
  ALGORITHM_TEST2 = 1

  # :nodoc:
  ALGORITHM_TEST3 = 2

  # Default algorithm. Taken from +chromaprint.h+
  ALGORITHM_DEFAULT = ALGORITHM_TEST2

  # Chromaprint works with 16 bit samples
  BYTES_PER_SAMPLE = 2

  # Get version of Chromaprint library
  #
  # @return [String] version
  def self.lib_version
    Lib.chromaprint_get_version
  end
end
