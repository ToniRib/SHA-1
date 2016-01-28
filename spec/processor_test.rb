require './lib/processor'
require './lib/preprocessor'
require './lib/binary_string'
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

  def test_preps_message_schedule_for_one_block_message
    message = one_segment_block

    message_schedule = {
      "t0" => BinaryString.new("01100001011000100110001101100100"),
      "t1" => BinaryString.new("01100101011000010110001001100011"),
      "t2" => BinaryString.new("01100100011001010110000101100010"),
      "t3" => BinaryString.new("01100011011001000110010101100001"),
      "t4" => BinaryString.new("01100010011000110110010001100101"),
      "t5" => BinaryString.new("01100001011000100110001101100100"),
      "t6" => BinaryString.new("01100101011000010110001001100011"),
      "t7" => BinaryString.new("01100100011001010110000101100010"),
      "t8" => BinaryString.new("01100011011001000110010101100001"),
      "t9" => BinaryString.new("01100010011000110110010001100101"),
      "t10" => BinaryString.new("01100001011000100110001101100100"),
      "t11" => BinaryString.new("01100101011000010110001001100011"),
      "t12" => BinaryString.new("01100100011001010110000101100010"),
      "t13" => BinaryString.new("01100011011001000110010101100001"),
      "t14" => BinaryString.new("01100010011000110110010001100101"),
      "t15" => BinaryString.new("01100001011000100110001101100100"),
      "t16" => BinaryString.new("00001010000011100000010000001100"),
      "t17" => BinaryString.new("00001100000010100000111000000100"),
      "t18" => BinaryString.new("00001100000011000000101000001110"),
      "t19" => BinaryString.new("11011010110100101100000011010100"),
      "t20" => BinaryString.new("11011110110110101101001011000000"),
      "t21" => BinaryString.new("11010100110111101101101011010010"),
      "t22" => BinaryString.new("01111101011010010100011101100111"),
      "t23" => BinaryString.new("01110011011111010110100101000111"),
      "t24" => BinaryString.new("10111001101011011011000110110111"),
      "t25" => BinaryString.new("11101100110000101001111011001010"),
      "t26" => BinaryString.new("11110100111011001100001010011110"),
      "t27" => BinaryString.new("11001010111101001110110011000010"),
      "t28" => BinaryString.new("01101000001111001001001000011010"),
      "t29" => BinaryString.new("01000100011010000011110010010010"),
      "t30" => BinaryString.new("10111111111000011001011110011001"),
      "t31" => BinaryString.new("11101100010100110010110001111010"),
      "t32" => BinaryString.new("11110111100011110000011001001111"),
      "t33" => BinaryString.new("00001011111101111000111100000111"),
      "t34" => BinaryString.new("10010100110100100110110001010101"),
      "t35" => BinaryString.new("01100110111011111110000100010110"),
      "t36" => BinaryString.new("10000000111100010001000101110101"),
      "t37" => BinaryString.new("11101110001100111100011010100100"),
      "t38" => BinaryString.new("00111011100101010000000010111110"),
      "t39" => BinaryString.new("11100110001110111001010100000101"),
      "t40" => BinaryString.new("10101001111110110110011110000100"),
      "t41" => BinaryString.new("00101100101010011111101101100010"),
      "t42" => BinaryString.new("11011100011100110101001110101001"),
      "t43" => BinaryString.new("10000011000100001010110110000100"),
      "t44" => BinaryString.new("11110111000010111101111100101000"),
      "t45" => BinaryString.new("00110100111101110000101111001011"),
      "t46" => BinaryString.new("11100001110101100111100111011001"),
      "t47" => BinaryString.new("11101101001010011101001010100001"),
      "t48" => BinaryString.new("11111100101000100000110010101011"),
      "t49" => BinaryString.new("01000000110011111101100101010101"),
      "t50" => BinaryString.new("01001010111100111111100001010000"),
      "t51" => BinaryString.new("11101110110111010000110100111011"),
      "t52" => BinaryString.new("00011001010000000010111101101100"),
      "t53" => BinaryString.new("11101100000110010100000001110100"),
      "t54" => BinaryString.new("00111010110010100010011110110001"),
      "t55" => BinaryString.new("01111101111101110010011101010100"),
      "t56" => BinaryString.new("11001010011001101111000111100100"),
      "t57" => BinaryString.new("10101011011110010101000000000101"),
      "t58" => BinaryString.new("00111000111110001010011100001010"),
      "t59" => BinaryString.new("00100110101110001011010100100001"),
      "t60" => BinaryString.new("01001001110010011011001100110001"),
      "t61" => BinaryString.new("00011010011111100111110000101000"),
      "t62" => BinaryString.new("00000010000011011100111111000100"),
      "t63" => BinaryString.new("00110011101100010011111100100011"),
      "t64" => BinaryString.new("11001100100100101111001001101110"),
      "t65" => BinaryString.new("00001110110011001001011101011110"),
      "t66" => BinaryString.new("10110001111101001001111000101010"),
      "t67" => BinaryString.new("11010001110111000001010000000001"),
      "t68" => BinaryString.new("11001001000111100101100101100100"),
      "t69" => BinaryString.new("01110100110010010000101001000100"),
      "t70" => BinaryString.new("01000110111110100001101100100000"),
      "t71" => BinaryString.new("01011000010000100010001000101100"),
      "t72" => BinaryString.new("10010101100010110101110110001000"),
      "t73" => BinaryString.new("10001011111011101101001010110101"),
      "t74" => BinaryString.new("00110001000011110101000001111011"),
      "t75" => BinaryString.new("11110001001000110000000100000000"),
      "t76" => BinaryString.new("00010010011010011110111001001000"),
      "t77" => BinaryString.new("11011000000100100011001001101000"),
      "t78" => BinaryString.new("11110010100011000100111100010100"),
      "t79" => BinaryString.new("11101110101011001100100000110010")
    }

    generated_schedule = @p.generate_schedule(message)

    generated_schedule.each do |iteration, binary_string|
      assert_equal message_schedule[iteration].value, binary_string.value
    end
  end

  def test_updates_the_T_working_var_first_time
    vars = {
      a: BinaryString.new("01100111010001010010001100000001"),
      b: BinaryString.new("11101111110011011010101110001001"),
      c: BinaryString.new("10011000101110101101110011111110"),
      d: BinaryString.new("00010000001100100101010001110110"),
      e: BinaryString.new("11000011110100101110000111110000")
    }

    w0 = BinaryString.new("01100001011000100110001101100100")
    t = 0

    expected = '00000001000101101111110000010111'

    assert_equal expected, @p.compute_temp(vars, w0, t).value
  end

  def test_updates_the_working_vars_for_t_0
    initial = {
      e: BinaryString.new("11000011110100101110000111110000"),
      d: BinaryString.new("00010000001100100101010001110110"),
      c: BinaryString.new("10011000101110101101110011111110"),
      b: BinaryString.new("11101111110011011010101110001001"),
      a: BinaryString.new("01100111010001010010001100000001")
    }

    w0 = BinaryString.new("01110100011011110110111001101001")
    t = 0

    expected = {
      e: BinaryString.new("00010000001100100101010001110110"),
      d: BinaryString.new("10011000101110101101110011111110"),
      c: BinaryString.new("01111011111100110110101011100010"),
      b: BinaryString.new("01100111010001010010001100000001"),
      a: BinaryString.new("00010100001001000000011100011100")
    }

    updated_vars = @p.update_working_vars(initial, w0, t)

    expected.each do |letter, binary_string|
      assert_equal binary_string.value, updated_vars[letter].value,
                   "Failed for letter #{letter}"
    end
  end

  def test_updates_the_working_vars_for_t_1
    initial = {
      e: BinaryString.new("00010000001100100101010001110110"),
      d: BinaryString.new("10011000101110101101110011111110"),
      c: BinaryString.new("01111011111100110110101011100010"),
      b: BinaryString.new("01100111010001010010001100000001"),
      a: BinaryString.new("00010100001001000000011100011100")
    }

    w1 = BinaryString.new("10000000000000000000000000000000")
    t = 1

    expected = {
      e: BinaryString.new("10011000101110101101110011111110"),
      d: BinaryString.new("01111011111100110110101011100010"),
      c: BinaryString.new("01011001110100010100100011000000"),
      b: BinaryString.new("00010100001001000000011100011100"),
      a: BinaryString.new("01101011001100011011000010001111")
    }

    updated_vars = @p.update_working_vars(initial, w1, t)

    expected.each do |letter, binary_string|
      assert_equal binary_string.value, updated_vars[letter].value,
                   "Failed for letter #{letter}"
    end
  end

  def test_computes_the_first_intermediate_hash
    working_vars = {
      e: BinaryString.new("00010000001100100101010001110110"),
      d: BinaryString.new("10011000101110101101110011111110"),
      c: BinaryString.new("01111011111100110110101011100010"),
      b: BinaryString.new("01100111010001010010001100000001"),
      a: BinaryString.new("00000001000101101111110000010111")
    }

    initial_hash = [
      BinaryString.new("01100111010001010010001100000001"),
      BinaryString.new("11101111110011011010101110001001"),
      BinaryString.new("10011000101110101101110011111110"),
      BinaryString.new("00010000001100100101010001110110"),
      BinaryString.new("11000011110100101110000111110000")
    ]

    intermediate_hash = [
      BinaryString.new("01101000010111000001111100011000"),
      BinaryString.new("01010111000100101100111010001010"),
      BinaryString.new("00010100101011100100011111100000"),
      BinaryString.new("10101000111011010011000101110100"),
      BinaryString.new("11010100000001010011011001100110")
    ]

    computed_intermediate_hash = @p.compute_intermediate_hash(initial_hash, working_vars)

    intermediate_hash.each_with_index do |binary_string, i|
      assert_equal binary_string.value, computed_intermediate_hash[i].value
    end
  end

  def test_computes_the_final_message_digest
    message = "toni"

    binary_message = [
      "01110100011011110110111001101001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000"
    ]

    expected = Digest::SHA1.hexdigest(message)

    assert_equal expected, @p.hexdigest(binary_message)
  end

  def test_computes_the_final_message_digest_for_a_long_message
    message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    binary_message = Preprocessor.new.binary_message(message)

    expected = Digest::SHA1.hexdigest(message)
    assert_equal expected, @p.hexdigest(binary_message)
  end

  def test_computes_two_block_message
    message = "abcde" * 20
    binary_message = Preprocessor.new.binary_message(message)

    expected = Digest::SHA1.hexdigest(message)
    assert_equal expected, @p.hexdigest(binary_message)
  end
end
