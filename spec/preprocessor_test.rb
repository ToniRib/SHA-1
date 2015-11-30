require 'preprocessor'
require 'minitest'

class PreprocessorTest < Minitest::Test
  def setup
    @p = Preprocessor.new
  end

  def test_converts_ascii_number_97_to_binary
    expected = '01100001'

    assert_equal expected, @p.byte_to_binary(97)
  end

  def test_converts_ascii_number_65_to_binary
    expected = '01000001'

    assert_equal expected, @p.byte_to_binary(65)
  end

  def test_converts_ascii_number_24_to_binary
    expected = '00011000'

    assert_equal expected, @p.byte_to_binary(24)
  end

  def test_converts_ascii_number_0_to_binary
    expected = '00000000'

    assert_equal expected, @p.byte_to_binary(0)
  end

  def test_word_to_binary_returns_empty_string_for_empty_string
    assert_equal '', @p.word_to_binary('')
  end

  def test_converts_lower_case_letter_to_binary
    expected = '01100001'

    assert_equal expected, @p.word_to_binary('a')
  end

  def test_converts_different_lower_case_letter_to_binary
    expected = '01111010'

    assert_equal expected, @p.word_to_binary('z')
  end

  def test_converts_upper_case_letter_to_binary
    expected = '01000100'

    assert_equal expected, @p.word_to_binary('D')
  end

  def test_converts_different_upper_case_letter_to_binary
    expected = '01010110'

    assert_equal expected, @p.word_to_binary('V')
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

  def test_creates_string_of_all_zeros_in_multiple_of_512
    expected = '0' * 512

    assert_equal expected, @p.zero_string(1)
  end

  # def test_calculates_padding_length_for_binary_string
  #   binary_string = '011000010110001001100011'
  #
  #   assert_equal 423, @p.padding_length(binary_string)
  # end
  #
  # def test_calculates_padding_length_for_different_binary_string
  #   binary_string = '0110000101100010'
  #
  #   assert_equal 431, @p.padding_length(binary_string)
  # end
  #
  # def test_pads_message
  #   message = 'abc'
  #   expected = '011000010110001001100011' + '1' + ('0' * 423)
  #
  #   assert_equal expected, @p.pad_message(message)
  #   assert_equal 448, @p.pad_message(message).length
  # end
  #
  # def test_pads_different_message
  #   message = 'a'
  #   expected = '01100001' + '1' + ('0' * 439)
  #
  #   assert_equal expected, @p.pad_message(message)
  #   assert_equal 448, @p.pad_message(message).length
  # end
  #
  # def test_final_padding_for_abc
  #   message = 'abc'
  #   expected = '011000010110001001100011' + '1' + ('0' * 423) + ('0' * 56) + '00011000'
  #
  #   assert_equal expected, @p.final_padding(message)
  #   assert_equal 512, @p.final_padding(message).length
  # end
  #
  # def test_parses_512_bit_message_into_one_array
  #   message = '011000010110001001100011' + '1' + ('0' * 423) + ('0' * 56) + '00011000'
  #   expected = [message]
  #
  #   assert_equal expected, @p.parse_message(message)
  # end
  #
  # def test_parses_1024_bit_message_into_one_array
  #   message = '011000010110001001100011' + '1' + ('0' * 423) + ('0' * 56) + '00011000'
  #   double_message = message * 2
  #   expected = [message, message]
  #
  #   assert_equal expected, @p.parse_message(double_message)
  # end
  #
  def test_initial_hash
    expected = ['67452301', 'efcdab89', '98badcfe', '10325476', 'c3d2e1f0']

    assert_equal expected, @p.initial_hash
  end
end
