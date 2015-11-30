require 'pry'

class Processor
  def circular_left_shift(binary, n)
    n.times { binary = binary[1..-1] + binary[0] }
    binary
  end

  def bitwise_exclusive_or(arr)
    # need to totally rework this
    '0' + (arr[0].to_i(2) ^ arr[1].to_i(2) ^ arr[2].to_i(2) ^ arr[3].to_i(2)).to_s(2)
  end
end
