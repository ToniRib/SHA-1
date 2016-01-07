require_relative 'word_operations'
require_relative 'ch_function'
require_relative 'parity_function'
require_relative 'maj_function'

# This class computes the output of the SHA-1 functions as defined in the spec
class SHA1Functions
  include WordOperations

  def calculate(x, y, z, t)
    if (0..19).cover?(t)
      ChFunction.new.compute(x, y, z)
    elsif (20..39).cover?(t) || (60..79).cover?(t)
      ParityFunction.new.compute(x, y, z)
    elsif (40..59).cover?(t)
      MajFunction.new.compute(x, y, z)
    end
  end
end
