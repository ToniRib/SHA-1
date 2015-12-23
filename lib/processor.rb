require 'pry'
require_relative 'preprocessor'

class Processor
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
    pre = Preprocessor.new

    {
      T: nil,
      a: pre.initial_hash[0],
      b: pre.initial_hash[1],
      c: pre.initial_hash[2],
      d: pre.initial_hash[3],
      e: pre.initial_hash[4]
    }
  end

  def process(message)
    message.each_with_index do |block, index|
      schedule = generate_schedule(block)

      if index_is_zero(index)
        working_vars = initialize_working_vars
      else
        working_vars = update_working_vars
      end

      hash = compute_intermediate_hash # need to figure this out
    end

    message_digest #something here
  end

  def index_is_zero(index)
    index.zero?
  end

  def constant_for_t_0_to_19
    '5a827999'
  end

  def constant_for_t_20_to_39
    '6ed9eba1'
  end

  def constant_for_t_40_to_59
    '8f1bbcdc'
  end

  def constant_for_t_60_to_79
    'cd62c1d6'
  end

  # write the crazy sha-1 function
end
