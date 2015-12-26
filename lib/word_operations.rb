module WordOperations
  def circular_left_shift(binary, n)
    binary.chars.rotate!(n).join
  end

  def bitwise_exclusive_or(arr)
    return arr.shift if arr.length == 1

    left = arr.shift
    right = bitwise_exclusive_or(arr)

    exclusive_or(left, right)
  end

  def exclusive_or(left, right)
    str = (left.to_i(2) ^ right.to_i(2)).to_s(2)
    pad_front_with_zeros(left.length, str)
  end

  def bitwise_and(a, b)
    str = (a.to_i(2) & b.to_i(2)).to_s(2)
    pad_front_with_zeros(a.length, str)
  end

  def bitwise_complement(binary)
    binary.chars.map { |n| flip_zero_and_one(n) }.join
  end

  def flip_zero_and_one(n)
    n == '0' ? 1 : 0
  end
end
