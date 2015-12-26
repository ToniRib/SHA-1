require_relative 'processor'
require_relative 'preprocessor'
require 'pry'

pre = Preprocessor.new
p = Processor.new

message = ARGV[0]

binary_message = pre.preprocess(message)
digest = p.process(binary_message)

puts "Your SHA-1 Hex Digest for the message '#{message}' is:"
puts digest
