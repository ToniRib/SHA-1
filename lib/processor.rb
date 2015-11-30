require 'pry'

class Processor
  def circular_left_shift(binary, n)
    n.times { binary = binary[1..-1] + binary[0] }
    binary
  end
end
