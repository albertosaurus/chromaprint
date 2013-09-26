module Chromaprint
  # Ports the chromaprint API functions. To get their detailed documentation
  # please see +chromaprint.h+ of the original C/C++ library.
  #
  # ref: https://bitbucket.org/acoustid/chromaprint/src/master/src/chromaprint.h
  module Lib
    extend FFI::Library
    ffi_lib 'chromaprint'


    # const char *chromaprint_get_version(void)
    attach_function :chromaprint_get_version, [], :string

    # ChromaprintContext *chromaprint_new(int algorithm)
    attach_function :chromaprint_new, [:int], :pointer

    # void chromaprint_free(ChromaprintContext *ctx)
    attach_function :chromaprint_free, [:pointer], :void

    # int chromaprint_start(ChromaprintContext *ctx, int sample_rate, int num_channels)
    attach_function :chromaprint_start, [:pointer, :int, :int], :int

    # int chromaprint_feed(ChromaprintContext *ctx, void *data, int size)
    attach_function :chromaprint_feed, [:pointer, :pointer, :int], :int

    # int chromaprint_finish(ChromaprintContext *ctx)
    attach_function :chromaprint_finish, [:pointer], :int

    # int chromaprint_get_fingerprint(ChromaprintContext *ctx, char **fingerprint)
    attach_function :chromaprint_get_fingerprint, [:pointer, :pointer], :int

    # int chromaprint_get_raw_fingerprint(ChromaprintContext *ctx, void **fingerprint, int *size)
    attach_function :chromaprint_get_raw_fingerprint, [:pointer, :pointer, :pointer], :int

    # int chromaprint_encode_fingerprint(void *fp, int size, int algorithm, void **encoded_fp, int *encoded_size, int base64)
    attach_function :chromaprint_encode_fingerprint, [:pointer, :int, :int, :pointer, :pointer, :int], :int

    # void chromaprint_dealloc(void *ptr);
    attach_function :chromaprint_dealloc, [:pointer], :void
  end
end
