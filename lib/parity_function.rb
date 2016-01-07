require_relative 'word_operations'

class ParityFunction
  include WordOperations

  def compute(x, y, z)
    bitwise_exclusive_or([x, y, z])
  end
end
