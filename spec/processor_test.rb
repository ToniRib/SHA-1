require 'minitest'
require 'processor'

class ProcessorTest < Minitest::Test
  def setup
    @p = Processor.new
  end

  def test_performs_circular_left_shift_one_time_on_binary_string
    str = '00010111'
    expected = '00101110'

    assert_equal expected, @p.circular_left_shift(str, 1)
  end

  def test_performs_circular_left_shift_three_times_on_binary_string
    str = '00010111'
    expected = '10111000'

    assert_equal expected, @p.circular_left_shift(str, 3)
  end

  def test_performs_bitwise_exclusive_or_on_four_binary_strings
    str1 = '0001'
    str2 = '0011'
    str3 = '0111'
    str4 = '0000'

    assert_equal '0101', @p.bitwise_exclusive_or([str1, str2, str3, str4])
  end
end
