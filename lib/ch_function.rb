require_relative 'word_operations'

class ChFunction
  include WordOperations

  def compute(x, y, z)
    x.complement!
    x_complement_and_z = bitwise_and(x, z)

    x.complement!
    x_and_y = bitwise_and(x, y)

    bitwise_exclusive_or([x_complement_and_z, x_and_y])
  end
end
