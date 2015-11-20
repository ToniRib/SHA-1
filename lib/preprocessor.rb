class Preprocessor
  def byte_to_binary(byte)
    byte.to_s(2).rjust(8, '0')
  end

  def word_to_binary(word)
    bin = ''
    word.each_byte { |c| bin += byte_to_binary(c) }
    bin
  end

  def padding_length(binary_str)
    (448 % 512) - (binary_str.length + 1)
  end

  def pad_message(message)
    word_to_binary(message) + '1' +
      ('0' * padding_length(word_to_binary(message)))
  end
end

# byte_to_binary(97)
# word_to_binary('abc')

# 448 % 512
