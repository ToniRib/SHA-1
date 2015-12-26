require './lib/sha1_functions'
require 'minitest/autorun'
require 'minitest/pride'

class SHA1FunctionsTest < Minitest::Test
  def setup
    @sha1 = SHA1Functions.new
  end

  def test_computes_ch_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '10011000'

    assert_equal expected, @sha1.ch_function(b, c, d)
  end

  def test_computes_ch_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '10011000101110101101110011111110'

    assert_equal expected, @sha1.ch_function(b, c, d)
  end

  def test_computes_parity_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '01100111'

    assert_equal expected, @sha1.parity_function(b, c, d)
  end

  def test_computes_parity_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '01100111010001010010001100000001'

    assert_equal expected, @sha1.parity_function(b, c, d)
  end

  def test_computes_maj_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '10011000'

    assert_equal expected, @sha1.maj_function(b, c, d)
  end

  def test_computes_maj_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '10011000101110101101110011111110'

    assert_equal expected, @sha1.maj_function(b, c, d)
  end

  def test_computes_sha_1_function_for_t_less_than_19
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "10011000101110101101110011111110"

    0.upto(19) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_20_and_39
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "01100111010001010010001100000001"

    20.upto(39) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_40_and_59
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "10011000101110101101110011111110"

    40.upto(59) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_60_and_79
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "01100111010001010010001100000001"

    60.upto(79) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t)
    end
  end
end
