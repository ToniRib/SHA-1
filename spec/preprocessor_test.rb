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
    assert_equal expected * 2, @p.zero_string(2)
  end

  def test_adds_message_and_one_bit_to_front_of_zero_string_for_short_message
    message = 'abc'

    zeros = '0' * 487
    expected = '011000010110001001100011' + '1' + zeros

    assert_equal expected, @p.add_message_and_one_bit(message)
  end

  def test_adds_message_and_one_bit_to_front_of_zero_string_for_long_message
    message = 'abc' * 20

    zeros = '0' * 543
    expected = '011000010110001001100011' * 20 + '1' + zeros

    assert_equal expected, @p.add_message_and_one_bit(message)
  end

  def test_encodes_message_length_as_sixty_four_bit_string
    message = 'abc'
    expected = ('0' * 56) + '00011000'

    assert_equal expected, @p.sixty_four_bit_encoded_message_length(message)
  end

  def test_encodes_long_message_length_as_sixty_four_bit_string
    message = 'abcde' * 20
    expected = ('0' * 54) + '1100100000'

    assert_equal expected, @p.sixty_four_bit_encoded_message_length(message)
  end

  def test_adds_length_as_64_bit_encoded_to_end_of_string_for_short_message
    message = 'abc'

    binary_length = ('0' * 56) + '00011000'
    zeros = '0' * 423
    expected = '011000010110001001100011' + '1' + zeros + binary_length

    assert_equal expected, @p.preprocess(message)
    assert_equal 512, @p.preprocess(message).length
  end

  def test_adds_length_as_64_bit_encoded_to_end_of_string_for_long_message
    message = 'abcde' * 20

    binary_length = ('0' * 54) + '1100100000'
    zeros = '0' * 159
    expected = '0110000101100010011000110110010001100101' * 20 + '1' + zeros + binary_length

    assert_equal expected, @p.preprocess(message)
    assert_equal 1024, @p.preprocess(message).length
  end

  def test_divides_message_into_512_bit_slices_for_short_message
    message = 'abc'
    preprocessed = @p.preprocess(message)

    binary_length = ('0' * 56) + '00011000'
    zeros = '0' * 423
    expected = '011000010110001001100011' + '1' + zeros + binary_length

    assert_equal [expected], @p.divide_into_512_bit_slices(preprocessed)
  end

  def test_divides_message_into_512_bit_slices_for_long_message
    message = 'abcde' * 20
    preprocessed = @p.preprocess(message)

    expected = ["01100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100", "01100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100100000"]

    assert_equal expected, @p.divide_into_512_bit_slices(preprocessed)
  end

  def test_initial_hash
    expected = ['67452301', 'efcdab89', '98badcfe', '10325476', 'c3d2e1f0']

    assert_equal expected, @p.initial_hash
  end
end
