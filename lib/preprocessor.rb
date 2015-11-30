require 'pry'

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

  # def padding_length(binary_str)
  #   # how to do smallest, non-negative?
  #   (448 % 512) - (binary_str.length + 1)
  # end
  #
  # def extra_pad(message)
  #   512 - pad_message(message).length - 8
  # end
  #
  # def pad_message(message)
  #   word_to_binary(message) + '1' +
  #     ('0' * padding_length(word_to_binary(message)))
  # end
  #
  # def final_padding(message)
  #   pad_message(message) + ('0' * extra_pad(message)) + byte_to_binary(word_to_binary(message).length)
  # end
  #
  # def parse_message(message)
  #   message.chars.each_slice(512).to_a.map do |msg|
  #     msg.join
  #   end
  # end

  def initial_hash
    h0 = '67452301'
    h1 = 'efcdab89'
    h2 = '98badcfe'
    h3 = '10325476'
    h4 = 'c3d2e1f0'
    [h0, h1, h2, h3, h4]
  end
end
