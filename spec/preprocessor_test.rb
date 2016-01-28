require './lib/preprocessor'
require 'minitest/autorun'
require 'minitest/pride'

class PreprocessorTest < Minitest::Test
  def setup
    @p = Preprocessor.new
  end

  def test_converts_ascii_number_97_to_binary
    expected = '01100001'

    assert_equal expected, @p.byte_to_binary(97)
  end

  def test_word_to_binary_returns_empty_string_for_empty_string
    assert_equal '', @p.word_to_binary('')
  end

  def test_converts_letter_to_binary
    expected = '01100001'

    assert_equal expected, @p.word_to_binary('a')
  end

  def test_converts_entire_string_to_binary
    expected = '011000010110001001100011'

    assert_equal expected, @p.word_to_binary('abc')
  end

  def test_calculates_number_of_blocks_for_small_string
    assert_equal 1, @p.number_of_blocks('abc')
  end

  def test_calculates_number_of_blocks_for_large_string
    message = 'a' * 60

    assert_equal 2, @p.number_of_blocks(message)
  end

  def test_encodes_message_length_as_sixty_four_bit_string
    message = 'abc'
    expected = ('0' * 56) + '00011000'

    assert_equal expected, @p.sixty_four_bit_encoded_message_length(message)
  end

  def test_adds_length_as_64_bit_encoded_to_end_of_string_for_short_message
    message = 'abc'

    binary_length = ('0' * 56) + '00011000'
    zeros = '0' * 423
    expected = '011000010110001001100011' + '1' + zeros + binary_length

    assert_equal [expected], @p.binary_message(message)
    assert_equal 512, @p.binary_message(message).first.length
  end

  def test_converts_test_message_to_binary_message
    message = 'A Test'

    expected = [
      "01000001001000000101010001100101011100110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000"
    ]

    assert_equal expected, @p.binary_message(message)
  end
end
