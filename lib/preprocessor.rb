class Preprocessor
  def byte_to_binary(byte)
    byte.to_s(2).rjust(8, '0')
  end

  def word_to_binary(word)
    bin = ''
    word.each_byte { |c| bin += byte_to_binary(c) }
    bin
  end

  def number_of_blocks(message)
    ((word_to_binary(message).length + 1 + 64) / 512.0).ceil
  end

  def zero_string(num_blocks)
    '0' * 512 * num_blocks
  end

  def add_message_and_one_bit(message)
    b = number_of_blocks(message)
    message_string = zero_string(b).prepend(word_to_binary(message) + '1')
    message_string.slice(0, b * 512)
  end

  def sixty_four_bit_encoded_message_length(message)
    l = byte_to_binary(message.length * 8)
    '0' * (64 - l.length) + l
  end

  def divide_into_512_bit_slices(binary)
    binary.chars.each_slice(512).to_a.map { |msg| msg.join }
  end

  def preprocess(message)
    l = sixty_four_bit_encoded_message_length(message)
    binary_message = add_message_and_one_bit(message)[0..-65] + l
    divide_into_512_bit_slices(binary_message)
  end
end
