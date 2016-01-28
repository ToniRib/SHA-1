class BinaryString
  attr_reader :value

  def initialize(value, adjusted_length = value.length)
    @value = value.rjust(adjusted_length, '0')
  end

  def to_base2_int
    value.to_i(2)
  end

  def length
    value.length
  end

  def complement!
    @value = value.chars.map { |n| flip_zero_and_one(n) }.join
  end

  def flip_zero_and_one(n)
    n == '0' ? 1 : 0
  end

  def circular_left_shift(n)
    value.chars.rotate!(n).join
  end
end
