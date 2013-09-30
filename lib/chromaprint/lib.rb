module Chromaprint
  # Ports the chromaprint API functions. To get their detailed documentation
  # please see +chromaprint.h+ of the original C/C++ library.
  #
  # ref: https://bitbucket.org/acoustid/chromaprint/src/master/src/chromaprint.h
  module Lib
    extend FFI::Library
    ffi_lib 'chromaprint'

    # Return the version number of Chromaprint.
    #
    # const char *chromaprint_get_version(void)
    attach_function :chromaprint_get_version, [], :string

    # Allocate and initialize the Chromaprint context.
    #
    # Parameters:
    #  - version: Version of the fingerprint algorithm, use
    #             CHROMAPRINT_ALGORITHM_DEFAULT for the default
    #             algorithm
    #
    # Returns:
    #  - Chromaprint context pointer
    #
    # ChromaprintContext *chromaprint_new(int algorithm)
    attach_function :chromaprint_new, [:int], :pointer

    # Deallocate the Chromaprint context.
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #
    # void chromaprint_free(ChromaprintContext *ctx)
    attach_function :chromaprint_free, [:pointer], :void

    # Return the fingerprint algorithm this context is configured to use.
    #
    # int chromaprint_get_algorithm(ChromaprintContext *ctx)
    #
    # @note
    #   In Debian Wheezy chromaprint.so (version 6.0.0) doesn't have
    #   chromaprint_get_algorithm() function. So we comment it out to not
    #   raise exception on loading.
    #
    # attach_function :chromaprint_get_algorithm, [:pointer], :int

    # Restart the computation of a fingerprint with a new audio stream.
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #  - sample_rate: sample rate of the audio stream (in Hz)
    #  - num_channels: numbers of channels in the audio stream (1 or 2)
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_start(ChromaprintContext *ctx, int sample_rate, int num_channels)
    attach_function :chromaprint_start, [:pointer, :int, :int], :int

    # Send audio data to the fingerprint calculator.
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #  - data: raw audio data, should point to an array of 16-bit signed
    #          integers in native byte-order
    #  - size: size of the data buffer (in samples)
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_feed(ChromaprintContext *ctx, void *data, int size)
    attach_function :chromaprint_feed, [:pointer, :pointer, :int], :int

    # Process any remaining buffered audio data and calculate the fingerprint.
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_finish(ChromaprintContext *ctx)
    attach_function :chromaprint_finish, [:pointer], :int

    # Return the calculated fingerprint as a compressed string.
    #
    # The caller is responsible for freeing the returned pointer using
    # chromaprint_dealloc().
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #  - fingerprint: pointer to a pointer, where a pointer to the allocated array
    #                 will be stored
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_get_fingerprint(ChromaprintContext *ctx, char **fingerprint)
    attach_function :chromaprint_get_fingerprint, [:pointer, :pointer], :int

    # Return the calculated fingerprint as an array of 32-bit integers.
    #
    # The caller is responsible for freeing the returned pointer using
    # chromaprint_dealloc().
    #
    # Parameters:
    #  - ctx: Chromaprint context pointer
    #  - fingerprint: pointer to a pointer, where a pointer to the allocated array
    #                 will be stored
    #  - size: number of items in the returned raw fingerprint
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_get_raw_fingerprint(ChromaprintContext *ctx, void **fingerprint, int *size)
    attach_function :chromaprint_get_raw_fingerprint, [:pointer, :pointer, :pointer], :int

    # Compress and optionally base64-encode a raw fingerprint
    #
    # The caller is responsible for freeing the returned pointer using
    # chromaprint_dealloc().
    #
    # Parameters:
    #  - fp: pointer to an array of 32-bit integers representing the raw
    #        fingerprint to be encoded
    #  - size: number of items in the raw fingerprint
    #  - algorithm: Chromaprint algorithm version which was used to generate the
    #               raw fingerprint
    #  - encoded_fp: pointer to a pointer, where the encoded fingerprint will be
    #                stored
    #  - encoded_size: size of the encoded fingerprint in bytes
    #  - base64: Whether to return binary data or base64-encoded ASCII data. The
    #            compressed fingerprint will be encoded using base64 with the
    #            URL-safe scheme if you set this parameter to 1. It will return
    #            binary data if it's 0.
    #
    # Returns:
    #  - 0 on error, 1 on success
    # int chromaprint_encode_fingerprint(void *fp, int size, int algorithm, void **encoded_fp, int *encoded_size, int base64)
    attach_function :chromaprint_encode_fingerprint, [:pointer, :int, :int, :pointer, :pointer, :int], :int

    # Uncompress and optionally base64-decode an encoded fingerprint
    #
    # The caller is responsible for freeing the returned pointer using
    # chromaprint_dealloc().
    #
    # Parameters:
    #  - encoded_fp: Pointer to an encoded fingerprint
    #  - encoded_size: Size of the encoded fingerprint in bytes
    #  - fp: Pointer to a pointer, where the decoded raw fingerprint (array
    #        of 32-bit integers) will be stored
    #  - size: Number of items in the returned raw fingerprint
    #  - algorithm: Chromaprint algorithm version which was used to generate the
    #               raw fingerprint
    #  - base64: Whether the encoded_fp parameter contains binary data or
    #            base64-encoded ASCII data. If 1, it will base64-decode the data
    #            before uncompressing the fingerprint.
    #
    # Returns:
    #  - 0 on error, 1 on success
    #
    # int chromaprint_decode_fingerprint(void *encoded_fp, int encoded_size, void **fp, int *size, int *algorithm, int base64)
    attach_function :chromaprint_decode_fingerprint, [:pointer, :int, :pointer, :pointer, :pointer, :int], :int

    # Free memory allocated by any function from the Chromaprint API.
    #
    #  - ptr: Pointer to be deallocated
    #
    # void chromaprint_dealloc(void *ptr);
    attach_function :chromaprint_dealloc, [:pointer], :void
  end
end
