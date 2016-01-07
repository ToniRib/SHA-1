require_relative 'word_operations'

class MajFunction
  include WordOperations

  def compute(x, y, z)
    left = bitwise_and(x, y)
    mid = bitwise_and(x, z)
    right = bitwise_and(y, z)

    bitwise_exclusive_or([left, mid, right])
  end
end
