require_relative 'word_operations'

# This class computes the output of the SHA-1 functions as defined in the spec
class SHA1Functions
  include WordOperations

  def ch_function(x, y, z)
    x_complement_and_z = bitwise_and(bitwise_complement(x), z)
    x_and_y = bitwise_and(x, y)

    bitwise_exclusive_or([x_complement_and_z, x_and_y])
  end

  def parity_function(x, y, z)
    bitwise_exclusive_or([x, y, z])
  end

  def maj_function(x, y, z)
    left = bitwise_and(x, y)
    mid = bitwise_and(x, z)
    right = bitwise_and(y, z)

    bitwise_exclusive_or([left, mid, right])
  end

  def calculate(x, y, z, t)
    if (0..19).cover?(t)
      ch_function(x, y, z)
    elsif (20..39).cover?(t) || (60..79).cover?(t)
      parity_function(x, y, z)
    elsif (40..59).cover?(t)
      maj_function(x, y, z)
    end
  end
end
