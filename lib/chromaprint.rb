require 'ffi'

require 'chromaprint/lib'
require 'chromaprint/context'
require 'chromaprint/fingerprint'

module Chromaprint
  # Taken from chromaprint.h
  ALGORITHM_TEST1 = 0
  ALGORITHM_TEST2 = 1
  ALGORITHM_TEST3 = 2

  # Default algorithm. Taken from chromaprint.h
  ALGORITHM_DEFAULT = ALGORITHM_TEST2

  # Chromaprint works with 16 bit samples
  BYTES_PER_SAMPLE = 2
end
