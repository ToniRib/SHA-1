require 'pry'

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
end
