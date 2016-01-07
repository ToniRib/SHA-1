require './lib/binary_string'
require 'minitest/autorun'
require 'minitest/pride'

class BinaryStringTest < Minitest::Test
  def test_to_base2_int_converts_binary_string_to_integer
    binary_string = '01100001'
    expected = 97

    assert_equal expected, BinaryString.new(binary_string).to_base2_int
  end

  def test_length_returns_length_of_binary_string
    binary_string = '01100001'
    expected =  8

    assert_equal expected, BinaryString.new(binary_string).length
  end

  def test_can_initialize_binary_string_with_padding
    length =  8
    binary_string = BinaryString.new('10001', length)

    expected = '00010001'

    assert_equal expected, binary_string.value
  end

  def test_complement_flips_ones_and_zeros_in_value
    binary_string = BinaryString.new('01010011')
    expected = '10101100'
    binary_string.complement!

    assert_equal expected, binary_string.value
  end

  def test_circular_left_shift_with_bang_shifts_value_to_left_by_n
    binary_string = BinaryString.new('00010111')

    expected = '00101110'
    binary_string.circular_left_shift!(1)
    assert_equal expected, binary_string.value

    expected = "10111000"
    binary_string.circular_left_shift!(2)
    assert_equal expected, binary_string.value
  end

  def test_circular_left_shift_without_bang_shifts_value_to_left_by_n
    binary_string = BinaryString.new('00010111')

    expected = '00101110'
    assert_equal expected, binary_string.circular_left_shift(1)

    expected = "10111000"
    assert_equal expected, binary_string.circular_left_shift(3)
  end
end
