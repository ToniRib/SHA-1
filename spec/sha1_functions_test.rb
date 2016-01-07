require './lib/sha1_functions'
require 'minitest/autorun'
require 'minitest/pride'

class SHA1FunctionsTest < Minitest::Test
  def setup
    @sha1 = SHA1Functions.new
  end

  def test_computes_sha_1_function_for_t_less_than_19
    x = BinaryString.new("11101111110011011010101110001001")
    y = BinaryString.new("10011000101110101101110011111110")
    z = BinaryString.new("00010000001100100101010001110110")

    expected = "10011000101110101101110011111110"

    0.upto(19) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t).value
    end
  end

  def test_computes_sha_1_function_for_t_between_20_and_39
    x = BinaryString.new("11101111110011011010101110001001")
    y = BinaryString.new("10011000101110101101110011111110")
    z = BinaryString.new("00010000001100100101010001110110")

    expected = "01100111010001010010001100000001"

    20.upto(39) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t).value
    end
  end

  def test_computes_sha_1_function_for_t_between_40_and_59
    x = BinaryString.new("11101111110011011010101110001001")
    y = BinaryString.new("10011000101110101101110011111110")
    z = BinaryString.new("00010000001100100101010001110110")

    expected = "10011000101110101101110011111110"

    40.upto(59) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t).value
    end
  end

  def test_computes_sha_1_function_for_t_between_60_and_79
    x = BinaryString.new("11101111110011011010101110001001")
    y = BinaryString.new("10011000101110101101110011111110")
    z = BinaryString.new("00010000001100100101010001110110")

    expected = "01100111010001010010001100000001"

    60.upto(79) do |t|
      assert_equal expected, @sha1.calculate(x, y, z, t).value
    end
  end
end
