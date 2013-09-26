module Chromaprint
  # Calculates fingerprints of audio data.
  #
  # @example
  #  chromaprint = Chromaprint::Context.new(44100, 1)
  #  data        = File.binread('song.wav')
  #  fingerprint = chromaprint.get_fingerprint(data)
  class Context
    # @param rate [Integer] sample rate of audio
    # @param num_channels [Integer] number of channels (1 or 2)
    # @param algorithm [Integer] specify algorithm to be used to Chromaprint
    #   library. Must be {ALGORITHM_TEST1}, {ALGORITHM_TEST2} or
    #   {ALGORITHM_TEST3}.
    def initialize(rate, num_channels, algorithm = ALGORITHM_DEFAULT)
      @rate         = rate
      @num_channels = num_channels
      @algorithm    = ALGORITHM_DEFAULT
    end


    # Calculate raw and compressed fingerprints of  the audio data.
    #
    #
    # @param data [String] raw audio data preseted by 16-bit signed integers
    #
    # @return [Chromaprint::Fingerprint]
    def get_fingerprint(data)
      # Allocate memory for context and initialize
      p_context = Lib.chromaprint_new(@algorithm)
      Lib.chromaprint_start(p_context, @rate, @num_channels)

      # Create a pointer to the data
      p_data = FFI::MemoryPointer.from_string(data)

      # Calculate number of samples and feed data.
      data_size = p_data.size / BYTES_PER_SAMPLE
      Lib.chromaprint_feed(p_context, p_data, data_size)

      # Calculate the fingerprint
      Lib.chromaprint_finish(p_context)

      # Get compressed fingerprint
      p_p_fingerprint = FFI::MemoryPointer.new(:pointer)
      Lib.chromaprint_get_fingerprint(p_context, p_p_fingerprint)
      p_fingerprint = p_p_fingerprint.get_pointer(0)
      fingerprint   = p_fingerprint.get_string(0)

      # Get raw fingerprint
      p_p_raw_fingerprint = FFI::MemoryPointer.new(:pointer)
      p_size              = FFI::MemoryPointer.new(:pointer)
      Lib.chromaprint_get_raw_fingerprint(p_context, p_p_raw_fingerprint, p_size)
      p_raw_fingerprint = p_p_raw_fingerprint.get_pointer(0)
      raw_fingerprint   = p_raw_fingerprint.get_array_of_uint(0, p_size.get_int32(0))

      Fingerprint.new(fingerprint, raw_fingerprint)
    ensure
      # Free memory
      Lib.chromaprint_free(p_context)            if p_context
      Lib.chromaprint_dealloc(p_fingerprint)     if p_fingerprint
      Lib.chromaprint_dealloc(p_raw_fingerprint) if p_raw_fingerprint
    end
  end
end
