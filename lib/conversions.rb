# This modules contains the methods to convert between different number systems
# and from strings with characters to their binary equivalent
module Conversions
  def hex_to_binary_string(hexstr)
    BinaryString.new(hexstr.hex.to_s(2), hexstr.size * 4)
  end

  def byte_to_binary(byte)
    byte.to_s(2).rjust(8, '0')
  end

  def word_to_binary(word)
    bin = ''
    word.each_byte { |c| bin += byte_to_binary(c) }
    bin
  end
end
