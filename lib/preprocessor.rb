class Preprocessor
  def byte_to_binary(byte)
    byte.to_s(2).rjust(8, '0')
  end

  def word_to_binary(word)
    bin = ''
    word.each_byte { |c| bin += byte_to_binary(c) }
    bin
  end
end

# byte_to_binary(97)
# word_to_binary('abc')
