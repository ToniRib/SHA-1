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

  def test_performs_bitwise_exclusive_or_on_two_binary_strings
    
  end
end
