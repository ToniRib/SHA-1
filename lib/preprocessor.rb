require_relative 'conversions'

# Preprocesses the original message by converting it to binary and performing
# the other operations required by the specification.
class Preprocessor
  include Conversions

  def binary_message(message)
    l = sixty_four_bit_encoded_message_length(message)
    binary_message = add_message_and_one_bit(message)[0..-65] + l
    divide_into_512_bit_slices(binary_message)
  end

  def number_of_blocks(message)
    ((length_of_binary_mesage(message) + 1 + 64) / 512.0).ceil
  end

  def sixty_four_bit_encoded_message_length(message)
    l = byte_to_binary(message.length * 8)
    '0' * (64 - l.length) + l
  end

  private

  def add_message_and_one_bit(message)
    b = number_of_blocks(message)
    message_string = zero_string(b).prepend(word_to_binary(message) + '1')
    message_string.slice(0, b * 512)
  end

  def divide_into_512_bit_slices(binary)
    binary.chars.each_slice(512).to_a.map(&:join)
  end

  def length_of_binary_mesage(message)
    word_to_binary(message).length
  end

  def zero_string(num_blocks)
    '0' * 512 * num_blocks
  end
end
