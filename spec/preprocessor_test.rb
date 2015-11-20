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
end
