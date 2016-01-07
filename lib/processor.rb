require_relative 'word_operations'
require_relative 'conversions'
require_relative 'sha1_functions'
require 'pry'

# Performs the actual processing of the string to create the message digest
# once all of the preprocessing has been performed.
class Processor
  include WordOperations
  include Conversions

  def initial_hash
    h0 = hex_to_binary_string('67452301')
    h1 = hex_to_binary_string('efcdab89')
    h2 = hex_to_binary_string('98badcfe')
    h3 = hex_to_binary_string('10325476')
    h4 = hex_to_binary_string('c3d2e1f0')

    [h0, h1, h2, h3, h4]
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

  def perform_xor_and_rotate_left_once(schedule, i)
    words = gather_previous_message_schedule_words(schedule, i)
    bitwise_xor = bitwise_exclusive_or(words)
    bitwise_xor.circular_left_shift!(1)
    bitwise_xor
  end

  def update_working_vars(vars, w, t)
    temp = compute_temp(vars, w, t)
    b = BinaryString.new(vars[:b].circular_left_shift(30))

    {
      e: vars[:d],
      d: vars[:c],
      c: b,
      b: vars[:a],
      a: temp
    }
  end

  def compute_temp(vars, w, t)
    rotated_a = vars[:a].circular_left_shift(5).to_i(2)
    sha_1 = SHA1Functions.new.calculate(vars[:b], vars[:c], vars[:d], t).to_base2_int
    constant = determine_constant(t).to_base2_int
    e = vars[:e].to_base2_int
    w = w.to_base2_int

    addition_modulo_2([rotated_a, sha_1, e, constant, w])
  end

  def compute_intermediate_hash(previous, working_vars)
    [
      add_previous_to_working(previous[0], working_vars[:a]),
      add_previous_to_working(previous[1], working_vars[:b]),
      add_previous_to_working(previous[2], working_vars[:c]),
      add_previous_to_working(previous[3], working_vars[:d]),
      add_previous_to_working(previous[4], working_vars[:e])
    ]
  end

  def add_previous_to_working(previous, working)
    addition_modulo_2([previous.to_base2_int, working.to_base2_int])
  end

  def process(message)
    hash_value = []

    message.each_with_index do |block, index|
      schedule = generate_schedule(block)

      hash_value = initial_hash if index.zero?

      working_vars = working_vars_as_current_hash_value(hash_value)

      0.upto(79) do |t|
        working_vars = update_working_vars(working_vars, schedule["t#{t}"], t)
      end

      hash_value = compute_intermediate_hash(hash_value, working_vars)
    end

    hash_value.map { |v| v.value }.join.to_i(2).to_s(16)
  end

  private

  def insert_sixteen_bits_of_message(block, i)
    BinaryString.new(block.chars.each_slice(32).to_a[i].join)
  end

  def gather_previous_message_schedule_words(schedule, i)
    [3, 8, 14, 16].map { |n| schedule['t' + (i - n).to_s] }
  end

  def working_vars_as_current_hash_value(hash_value)
    {
      a: hash_value[0],
      b: hash_value[1],
      c: hash_value[2],
      d: hash_value[3],
      e: hash_value[4]
    }
  end


  def determine_constant(t)
    if (0..19).cover?(t)
      hex_to_binary_string('5a827999')
    elsif (20..39).cover?(t)
      hex_to_binary_string('6ed9eba1')
    elsif (40..59).cover?(t)
      hex_to_binary_string('8f1bbcdc')
    elsif (60..79).cover?(t)
      hex_to_binary_string('ca62c1d6')
    end
  end
end
