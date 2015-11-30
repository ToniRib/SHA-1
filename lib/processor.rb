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
end
