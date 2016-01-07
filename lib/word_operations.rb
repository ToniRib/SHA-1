require_relative 'binary_string'
require 'pry'

# This module contains the methods necessary to perform the logical operations
# on various 32-bit words.
module WordOperations
  def bitwise_exclusive_or(arr)
    return arr.first if arr.length == 1

    left = arr.first
    right = bitwise_exclusive_or(arr[1..-1])
    exclusive_or(left, right)
  end

  def exclusive_or(x, y)
    integer = x.to_base2_int ^ y.to_base2_int
    BinaryString.new(integer.to_s(2), x.length)
  end

  def bitwise_and(x, y)
    integer = x.to_base2_int & y.to_base2_int
    BinaryString.new(integer.to_s(2), x.length)
  end

  def addition_modulo_2(integers)
    BinaryString.new((integers.reduce(:+) % (2**32)).to_s(2), 32)
  end
end
