# SHA-1 Algorithm in Object-Oriented Ruby

## Overview

This code implements the SHA-1 hashing algorithm as described in the [Federal Information Processing Standards Publication: Secure Hash Standard](http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf) using an object-oriented approach in pure ruby.

## Command Line Interface

This program can be run from the command line in the base directory of the project by using the following command format:

```
$ ruby lib/sha1_hexdigest.rb message
```

where `message` can either either be in quotes or not in quotes.

### Examples

```
$ ruby lib/sha1_hexdigest.rb toni
Your SHA-1 Hex Digest for the message 'toni' is:
532ff71c0f0c138e61afd0c77279be9f5bb6c4f0

$ ruby lib/sha1_hexdigest.rb 'longer multi word message in quotes'
Your SHA-1 Hex Digest for the message 'longer multi word message in quotes' is:
b1676709057f22073ee08832f2d91f05a90e7a0b
```

## Testing Suite

Each class has a corresponding testing file written with [minitest](https://github.com/seattlerb/minitest) which can be run from the terminal using [mrspec]https://github.com/JoshCheek/mrspec): 

```
$ mrspec

Preprocessor
  encodes long message length as sixty four bit string
  converts lower case letter to binary
  creates initial hash in binary
  calculates number of blocks for large string
  converts ascii number 24 to binary
  converts different upper case letter to binary
  << further output omitted for brevity >>
```

#### Dependencies

Must have the [mrspec gem](https://github.com/JoshCheek/mrspec) and [minitest gem](https://github.com/seattlerb/minitest) installed.

Alternatively, you could run the tests without using mrspec by running the following command with the name of one of the test files:

```
$ ruby spec/preprocessor_test.rb
Run options: --seed 21667

# Running:

.......................

Fabulous run in 0.004672s, 4923.4405 runs/s, 5565.6284 assertions/s.

23 runs, 26 assertions, 0 failures, 0 errors, 0 skips
```

No other gems are required to run this program.
