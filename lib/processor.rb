require_relative 'word_operations'
require_relative 'conversions'
require_relative 'sha1_functions'

# Performs the actual processing of the string to create the message digest
# once all of the preprocessing has been performed.
class Processor
  include WordOperations
  include Conversions

  def initial_hash
    h0 = hex_to_binary('67452301')
    h1 = hex_to_binary('efcdab89')
    h2 = hex_to_binary('98badcfe')
    h3 = hex_to_binary('10325476')
    h4 = hex_to_binary('c3d2e1f0')

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
      a: initial_hash[0],
      b: initial_hash[1],
      c: initial_hash[2],
      d: initial_hash[3],
      e: initial_hash[4]
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
    sha_1 = SHA1Functions.new.calculate(b, c, d, t).to_i(2)
    constant = determine_constant(t).to_i(2)
    e = e.to_i(2)
    w = w.to_i(2)

    addition_modulo_2([rotated_a, sha_1, e, constant, w])
  end

  def compute_intermediate_hash(previous, working_vars)
    [
      add_previous_to_working(previous, working_vars, 0, :a),
      add_previous_to_working(previous, working_vars, 1, :b),
      add_previous_to_working(previous, working_vars, 2, :c),
      add_previous_to_working(previous, working_vars, 3, :d),
      add_previous_to_working(previous, working_vars, 4, :e)
    ]
  end

  def add_previous_to_working(previous, working, i, letter)
    addition_modulo_2([previous[i].to_i(2), working[letter].to_i(2)])
  end

  def process(message)
    hash_value = []

    message.each_with_index do |block, index|
      schedule = generate_schedule(block)

      if index.zero?
        hash_value = initial_hash
        working_vars = initialize_working_vars
      else
        working_vars = working_vars_as_current_hash_value(hash_value)
      end

      0.upto(79) do |t|
        working_vars = update_working_vars(working_vars, schedule["t#{t}"], t)
      end

      hash_value = compute_intermediate_hash(hash_value, working_vars)
    end

    hash_value.join.to_i(2).to_s(16)
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

  private

  def determine_constant(t)
    if (0..19).cover?(t)
      hex_to_binary('5a827999')
    elsif (20..39).cover?(t)
      hex_to_binary('6ed9eba1')
    elsif (40..59).cover?(t)
      hex_to_binary('8f1bbcdc')
    elsif (60..79).cover?(t)
      hex_to_binary('ca62c1d6')
    end
  end
end
