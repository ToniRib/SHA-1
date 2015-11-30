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

    (left.to_i(2) ^ right.to_i(2)).to_s(2).rjust(left.length, '0')
  end

  def generate_schedule(message)
    # update for one block only
    schedule = {}

    message.each do |block|
      80.times do |i|

        if i < 16
          schedule['t' + i.to_s] = block.chars.each_slice(32).to_a[i].join
        else
          schedule['t' + i.to_s] = circular_left_shift(bitwise_exclusive_or([schedule['t' + (i - 3).to_s], schedule['t' + (i - 8).to_s], schedule['t' + (i - 14).to_s], schedule['t' + (i - 16).to_s]]), 1)
        end
      end
    end

    schedule
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

      if index == 0
        working_vars = initialize_working_vars
      else
        working_vars = update_working_vars
      end

      hash = compute_intermediate_hash # need to figure this out
    end

    message_digest #something here
  end

  # write the crazy sha-1 function
end
