require 'pry'

class Processor
  def circular_left_shift(binary, n)
    binary.chars.rotate!(n).join
  end

  def bitwise_exclusive_or(arr)
    return arr.shift if arr.length == 1
    # need to totally rework this
    # '0' + (arr[0].to_i(2) ^ arr[1].to_i(2) ^ arr[2].to_i(2) ^ arr[3].to_i(2)).to_s(2)

    left = arr.shift
    right = bitwise_exclusive_or(arr)
  end
end
