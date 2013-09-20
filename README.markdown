# Chromaprint

Port of [Chromaprint](http://acoustid.org/chromaprint) C/C++ library to Ruby.

> It's a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.


## Dependencies

* Chromaprint

### Debian / Ubuntu

```sh
apt-get install libchromaprint-dev
```

### Mac

```
brew install chromaprint
```

## Usage

```ruby
# Create context for rate=44100 and channel=1.
context1 = Chromaprint::Context.new(44100, 1)

# Get audio data. Data should be in raw audio format with 16-bit signed samples.
# The library doesn't care about decoding formats like mp3 or ogg, you should
# do it yourself.
data1 = File.binread('/1.wav')

# Get fingerprint from data.
fingerprint1 = context1.get_fingerprint(data1)

# Create context for rate=22050 and channel=2.
context2 = Chromaprint::Context.new(22050, 2)
fingerprint2 = context2.get_fingerprint(File.binread('/2.wav')

# Compressed fingerprint, returned by chromaprint_get_fingerprint() C function.
fingerprint1.compressed  # => "AQAALOkUKdlChE92NNeFn8EjF9..."

# Raw fingerprint, returned by chromaprint_get_raw_fingerprint() C function.
fingerprint1.raw  # => [294890785, 328373552, 315802880, 303481088, ...]

# Compare 2 fingerprints, result is 0..1 range, where 1 is 100% similarity.
fingerprint1.compare(fingerprint2)  # => 0.93231
```

## Run tests

```sh
rake spec
```

## Credits

* [Sergey Potapov](https://github.com/greyblake)

## Copyright

Copyright (c) 2013 TMX Credit.
