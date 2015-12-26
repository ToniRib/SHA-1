require './lib/processor'
require 'minitest/autorun'
require 'minitest/pride'
require 'digest'

class ProcessorTest < Minitest::Test
  def setup
    @p = Processor.new
  end

  def one_segment_block
    "01100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100011001010110000101100010011000110110010001100101011000010110001001100011011001000110010101100001011000100110001101100100"
  end

  def test_creates_initial_hash_in_binary
    expected = [
      "01100111010001010010001100000001",
      "11101111110011011010101110001001",
      "10011000101110101101110011111110",
      "00010000001100100101010001110110",
      "11000011110100101110000111110000"
    ]

    assert_equal expected, @p.initial_hash
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

  def test_performs_bitwise_exclusive_or_on_four_long_binary_strings
    str1 = '000100101'
    str2 = '001110000'
    str3 = '011111011'
    str4 = '000010000'

    assert_equal '010111110', @p.bitwise_exclusive_or([str1, str2, str3, str4])
  end

  def test_performs_bitwise_and_on_two_binary_strings
    str1 = '0001'
    str2 = '0011'
    str3 = '1011'

    assert_equal '0001', @p.bitwise_and(str1, str2)
    assert_equal '0011', @p.bitwise_and(str2, str3)
  end

  def test_performs_bitwise_complement_on_a_binary_string
    str1 = '0001'
    str2 = '0011'

    assert_equal '1110', @p.bitwise_complement(str1)
    assert_equal '1100', @p.bitwise_complement(str2)
  end

  def test_preps_message_schedule_for_one_block_message
    message = one_segment_block

    message_schedule = {
      "t0" => "01100001011000100110001101100100",
      "t1" => "01100101011000010110001001100011",
      "t2" => "01100100011001010110000101100010",
      "t3" => "01100011011001000110010101100001",
      "t4" => "01100010011000110110010001100101",
      "t5" => "01100001011000100110001101100100",
      "t6" => "01100101011000010110001001100011",
      "t7" => "01100100011001010110000101100010",
      "t8" => "01100011011001000110010101100001",
      "t9" => "01100010011000110110010001100101",
      "t10" => "01100001011000100110001101100100",
      "t11" => "01100101011000010110001001100011",
      "t12" => "01100100011001010110000101100010",
      "t13" => "01100011011001000110010101100001",
      "t14" => "01100010011000110110010001100101",
      "t15" => "01100001011000100110001101100100",
      "t16" => "00001010000011100000010000001100",
      "t17" => "00001100000010100000111000000100",
      "t18" => "00001100000011000000101000001110",
      "t19" => "11011010110100101100000011010100",
      "t20" => "11011110110110101101001011000000",
      "t21" => "11010100110111101101101011010010",
      "t22" => "01111101011010010100011101100111",
      "t23" => "01110011011111010110100101000111",
      "t24" => "10111001101011011011000110110111",
      "t25" => "11101100110000101001111011001010",
      "t26" => "11110100111011001100001010011110",
      "t27" => "11001010111101001110110011000010",
      "t28" => "01101000001111001001001000011010",
      "t29" => "01000100011010000011110010010010",
      "t30" => "10111111111000011001011110011001",
      "t31" => "11101100010100110010110001111010",
      "t32" => "11110111100011110000011001001111",
      "t33" => "00001011111101111000111100000111",
      "t34" => "10010100110100100110110001010101",
      "t35" => "01100110111011111110000100010110",
      "t36" => "10000000111100010001000101110101",
      "t37" => "11101110001100111100011010100100",
      "t38" => "00111011100101010000000010111110",
      "t39" => "11100110001110111001010100000101",
      "t40" => "10101001111110110110011110000100",
      "t41" => "00101100101010011111101101100010",
      "t42" => "11011100011100110101001110101001",
      "t43" => "10000011000100001010110110000100",
      "t44" => "11110111000010111101111100101000",
      "t45" => "00110100111101110000101111001011",
      "t46" => "11100001110101100111100111011001",
      "t47" => "11101101001010011101001010100001",
      "t48" => "11111100101000100000110010101011",
      "t49" => "01000000110011111101100101010101",
      "t50" => "01001010111100111111100001010000",
      "t51" => "11101110110111010000110100111011",
      "t52" => "00011001010000000010111101101100",
      "t53" => "11101100000110010100000001110100",
      "t54" => "00111010110010100010011110110001",
      "t55" => "01111101111101110010011101010100",
      "t56" => "11001010011001101111000111100100",
      "t57" => "10101011011110010101000000000101",
      "t58" => "00111000111110001010011100001010",
      "t59" => "00100110101110001011010100100001",
      "t60" => "01001001110010011011001100110001",
      "t61" => "00011010011111100111110000101000",
      "t62" => "00000010000011011100111111000100",
      "t63" => "00110011101100010011111100100011",
      "t64" => "11001100100100101111001001101110",
      "t65" => "00001110110011001001011101011110",
      "t66" => "10110001111101001001111000101010",
      "t67" => "11010001110111000001010000000001",
      "t68" => "11001001000111100101100101100100",
      "t69" => "01110100110010010000101001000100",
      "t70" => "01000110111110100001101100100000",
      "t71" => "01011000010000100010001000101100",
      "t72" => "10010101100010110101110110001000",
      "t73" => "10001011111011101101001010110101",
      "t74" => "00110001000011110101000001111011",
      "t75" => "11110001001000110000000100000000",
      "t76" => "00010010011010011110111001001000",
      "t77" => "11011000000100100011001001101000",
      "t78" => "11110010100011000100111100010100",
      "t79" => "11101110101011001100100000110010"
    }

    t16 = '00001010000011100000010000001100'

    assert_equal message_schedule, @p.generate_schedule(message)
    assert_equal t16, @p.generate_schedule(message)['t16']
  end

  def test_working_vars_initialize_as_initial_hash
    expected = {
      a: "01100111010001010010001100000001",
      b: "11101111110011011010101110001001",
      c: "10011000101110101101110011111110",
      d: "00010000001100100101010001110110",
      e: "11000011110100101110000111110000"
    }

    assert_equal expected, @p.initialize_working_vars
  end

  def test_computes_ch_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '10011000'

    assert_equal expected, @p.ch_function(b, c, d)
  end

  def test_computes_ch_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '10011000101110101101110011111110'

    assert_equal expected, @p.ch_function(b, c, d)
  end

  def test_computes_parity_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '01100111'

    assert_equal expected, @p.parity_function(b, c, d)
  end

  def test_computes_parity_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '01100111010001010010001100000001'

    assert_equal expected, @p.parity_function(b, c, d)
  end

  def test_computes_maj_function_for_three_short_variables
    b = "11101111"
    c = "10011000"
    d = "00010000"

    expected = '10011000'

    assert_equal expected, @p.maj_function(b, c, d)
  end

  def test_computes_maj_function_for_three_variables
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"

    expected = '10011000101110101101110011111110'

    assert_equal expected, @p.maj_function(b, c, d)
  end

  def test_computes_sha_1_function_for_t_less_than_19
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "10011000101110101101110011111110"

    0.upto(19) do |t|
      assert_equal expected, @p.sha_1_function(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_20_and_39
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "01100111010001010010001100000001"

    20.upto(39) do |t|
      assert_equal expected, @p.sha_1_function(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_40_and_59
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "10011000101110101101110011111110"

    40.upto(59) do |t|
      assert_equal expected, @p.sha_1_function(x, y, z, t)
    end
  end

  def test_computes_sha_1_function_for_t_between_60_and_79
    x = "11101111110011011010101110001001"
    y = "10011000101110101101110011111110"
    z = "00010000001100100101010001110110"

    expected = "01100111010001010010001100000001"

    60.upto(79) do |t|
      assert_equal expected, @p.sha_1_function(x, y, z, t)
    end
  end

  def test_updates_the_T_working_var_first_time
    a = "01100111010001010010001100000001"
    b = "11101111110011011010101110001001"
    c = "10011000101110101101110011111110"
    d = "00010000001100100101010001110110"
    e = "11000011110100101110000111110000"
    w0 = "01100001011000100110001101100100"
    t = 0

    expected = '00000001000101101111110000010111'

    assert_equal expected, @p.compute_temp(a, b, c, d, e, w0, t)
  end

  def test_updates_the_working_vars_for_t_0
    initial = {
      e: "11000011110100101110000111110000",
      d: "00010000001100100101010001110110",
      c: "10011000101110101101110011111110",
      b: "11101111110011011010101110001001",
      a: "01100111010001010010001100000001"
    }

    w0 = "01110100011011110110111001101001"
    t = 0

    expected = {
      e: "00010000001100100101010001110110",
      d: "10011000101110101101110011111110",
      c: "01111011111100110110101011100010",
      b: "01100111010001010010001100000001",
      a: "00010100001001000000011100011100"
    }

    assert_equal expected, @p.update_working_vars(initial, w0, t)
  end

  def test_updates_the_working_vars_for_t_1
    initial = {
      e: "00010000001100100101010001110110",
      d: "10011000101110101101110011111110",
      c: "01111011111100110110101011100010",
      b: "01100111010001010010001100000001",
      a: "00010100001001000000011100011100"
    }

    w1 = "10000000000000000000000000000000"
    t = 1

    expected = {
      e: "10011000101110101101110011111110",
      d: "01111011111100110110101011100010",
      c: "01011001110100010100100011000000",
      b: "00010100001001000000011100011100",
      a: "01101011001100011011000010001111"
    }

    assert_equal expected, @p.update_working_vars(initial, w1, t)
  end

  def test_computes_the_first_intermediate_hash
    working_vars = {
      e: "00010000001100100101010001110110",
      d: "10011000101110101101110011111110",
      c: "01111011111100110110101011100010",
      b: "01100111010001010010001100000001",
      a: "00000001000101101111110000010111"
    }

    initial_hash = [
      "01100111010001010010001100000001",
      "11101111110011011010101110001001",
      "10011000101110101101110011111110",
      "00010000001100100101010001110110",
      "11000011110100101110000111110000"
    ]

    intermediate_hash = [
      "01101000010111000001111100011000",
      "01010111000100101100111010001010",
      "00010100101011100100011111100000",
      "10101000111011010011000101110100",
      "11010100000001010011011001100110"
    ]

    assert_equal intermediate_hash, @p.compute_intermediate_hash(initial_hash, working_vars)
  end

  def test_computes_the_final_message_digest
    message = "toni"

    binary_message = [
      "01110100011011110110111001101001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000"
    ]

    expected = Digest::SHA1.hexdigest(message)

    assert_equal expected, @p.process(binary_message)
  end

  def test_computes_the_final_message_digest_for_a_long_message
    message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

    binary_message = [
      "01001100011011110111001001100101011011010010000001101001011100000111001101110101011011010010000001100100011011110110110001101111011100100010000001110011011010010111010000100000011000010110110101100101011101000010110000100000011000110110111101101110011100110110010101100011011101000110010101110100011101010111001000100000011000010110010001101001011100000110100101110011011000110110100101101110011001110010000001100101011011000110100101110100001011000010000001110011011001010110010000100000011001000110111100100000",
      "01100101011010010111010101110011011011010110111101100100001000000111010001100101011011010111000001101111011100100010000001101001011011100110001101101001011001000110100101100100011101010110111001110100001000000111010101110100001000000110110001100001011000100110111101110010011001010010000001100101011101000010000001100100011011110110110001101111011100100110010100100000011011010110000101100111011011100110000100100000011000010110110001101001011100010111010101100001001011100010000001010101011101000010000001100101",
      "01101110011010010110110100100000011000010110010000100000011011010110100101101110011010010110110100100000011101100110010101101110011010010110000101101101001011000010000001110001011101010110100101110011001000000110111001101111011100110111010001110010011101010110010000100000011001010111100001100101011100100110001101101001011101000110000101110100011010010110111101101110001000000111010101101100011011000110000101101101011000110110111100100000011011000110000101100010011011110111001001101001011100110010000001101110",
      "01101001011100110110100100100000011101010111010000100000011000010110110001101001011100010111010101101001011100000010000001100101011110000010000001100101011000010010000001100011011011110110110101101101011011110110010001101111001000000110001101101111011011100111001101100101011100010111010101100001011101000010111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011100111000"
    ]

    expected = Digest::SHA1.hexdigest(message)

    assert_equal expected, @p.process(binary_message)
  end
end
