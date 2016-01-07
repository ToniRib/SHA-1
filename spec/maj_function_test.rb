require 'minitest/autorun'
require 'minitest/pride'
require './lib/maj_function'

class MajFunctionTest < Minitest::Test
  def test_computes_maj_function_for_three_short_variables
    x = BinaryString.new("11101111")
    y = BinaryString.new("10011000")
    z = BinaryString.new("00010000")

    expected = '10011000'

    assert_equal expected, MajFunction.new.compute(x, y, z).value
  end

  def test_computes_maj_function_for_three_variables
    x = BinaryString.new("11101111110011011010101110001001")
    y = BinaryString.new("10011000101110101101110011111110")
    z = BinaryString.new("00010000001100100101010001110110")

    expected = '10011000101110101101110011111110'

    assert_equal expected, MajFunction.new.compute(x, y, z).value
  end
end
