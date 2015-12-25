require 'pry'
require_relative 'preprocessor'

class Processor
  def initialize
    @pre = Preprocessor.new
  end

  def circular_left_shift(binary, n)
    binary.chars.rotate!(n).join
  end

  def bitwise_exclusive_or(arr)
    return arr.shift if arr.length == 1

    left = arr.shift
    right = bitwise_exclusive_or(arr)

    pad_exclusive_or(left, right)
  end

  def pad_exclusive_or(left, right)
    (left.to_i(2) ^ right.to_i(2)).to_s(2).rjust(left.length, '0')
  end

  def bitwise_and(a, b)
    (a.to_i(2) & b.to_i(2)).to_s(2).rjust(a.length, '0')
  end

  def bitwise_complement(binary)
    complement = binary.chars.map do |n|
      n.to_i == 0 ? 1 : 0
    end

    complement.join
  end

  def ch_function(x, y, z)
    x_complement_and_z = bitwise_and(bitwise_complement(x), z)
    x_and_y = bitwise_and(x, y)
    bitwise_exclusive_or([x_complement_and_z, x_and_y])
  end

  def parity_function(x, y, z)
    bitwise_exclusive_or([x, y, z])
  end

  def maj_function(x, y, z)
    left = bitwise_and(x, y)
    mid = bitwise_and(x, z)
    right = bitwise_and(y, z)
    bitwise_exclusive_or([left, mid, right])
  end

  def sha_1_function(x, y, z, t)
    if (0..19).cover?(t)
      ch_function(x, y, z)
    elsif (20..39).cover?(t) || (60..79).cover?(t)
      parity_function(x, y, z)
    elsif (40..59).cover?(t)
      maj_function(x, y, z)
    end
  end

  def generate_schedule(block)
    schedule = {}

    80.times do |i|
      if i < 16
        schedule['t' + i.to_s] = insert_sixteen_bits_of_message(block, i)
      else
        schedule['t' + i.to_s] = perform_xor_and_rotate_left_once(schedule, i)
      end
    end

    schedule
  end

  def insert_sixteen_bits_of_message(block, i)
    block.chars.each_slice(32).to_a[i].join
  end

  def gather_previous_message_schedule_words(schedule, i)
    [schedule['t' + (i - 3).to_s],
     schedule['t' + (i - 8).to_s],
     schedule['t' + (i - 14).to_s],
     schedule['t' + (i - 16).to_s]]
  end

  def perform_xor_and_rotate_left_once(schedule, i)
    words = gather_previous_message_schedule_words(schedule, i)
    bitwise_xor = bitwise_exclusive_or(words)
    circular_left_shift(bitwise_xor, 1)
  end

  def initialize_working_vars
    {
      a: @pre.initial_hash[0],
      b: @pre.initial_hash[1],
      c: @pre.initial_hash[2],
      d: @pre.initial_hash[3],
      e: @pre.initial_hash[4]
    }
  end

  def update_working_vars(vars, w, t)
    temp = compute_temp(vars[:a], vars[:b], vars[:c], vars[:d], vars[:e], w, t)

    {
      e: vars[:d],
      d: vars[:c],
      c: circular_left_shift(vars[:b], 30),
      b: vars[:a],
      a: temp
    }
  end

  def compute_temp(a, b, c, d, e, w, t)
    rotated_a = circular_left_shift(a, 5).to_i(2)
    sha_1 = sha_1_function(b, c, d, t).to_i(2)
    constant = determine_constant(t).to_i(2)
    e = e.to_i(2)
    w = w.to_i(2)
    modulo = 2**32

    addition_modulo_2([rotated_a, sha_1, e, constant, w])
  end

  def addition_modulo_2(integers)
    binary = (integers.reduce(:+) % (2**32)).to_s(2)
    binary.rjust(32, '0')
  end

  def compute_intermediate_hash(previous, working_vars)
    [
      addition_modulo_2([previous[0].to_i(2), working_vars[:a].to_i(2)]),
      addition_modulo_2([previous[1].to_i(2), working_vars[:b].to_i(2)]),
      addition_modulo_2([previous[2].to_i(2), working_vars[:c].to_i(2)]),
      addition_modulo_2([previous[3].to_i(2), working_vars[:d].to_i(2)]),
      addition_modulo_2([previous[4].to_i(2), working_vars[:e].to_i(2)]),
    ]
  end

  def process(message)
    hash_value = []

    message.each_with_index do |block, index|
      schedule = generate_schedule(block)

      # need to check below here
      if index_is_zero(index)
        hash_value = @pre.initial_hash
        working_vars = initialize_working_vars
      else
        working_vars = set_working_vars(hash_value)
      end

      0.upto(79) do |t|
        working_vars = update_working_vars(working_vars, schedule["t#{index}"], t)
      end

      hash_value = compute_intermediate_hash(hash_value, working_vars)
    end

    # binding.pry
    hash_value.join.to_i(2).to_s(16)
  end

  def set_working_vars(hash_value)
    {
      a: hash_value[0],
      b: hash_value[1],
      c: hash_value[2],
      d: hash_value[3],
      e: hash_value[4]
    }
  end

  def index_is_zero(index)
    index.zero?
  end

  def determine_constant(t)
    if (0..19).cover?(t)
      constant_for_t_0_to_19
    elsif (20..39).cover?(t)
      constant_for_t_20_to_39
    elsif (40..59).cover?(t)
      constant_for_t_40_to_59
    elsif (60..79).cover?(t)
      constant_for_t_60_to_79
    end
  end

  def constant_for_t_0_to_19
    @pre.hex_to_binary('5a827999')
  end

  def constant_for_t_20_to_39
    @pre.hex_to_binary('6ed9eba1')
  end

  def constant_for_t_40_to_59
    @pre.hex_to_binary('8f1bbcdc')
  end

  def constant_for_t_60_to_79
    @pre.hex_to_binary('cd62c1d6')
  end
end
