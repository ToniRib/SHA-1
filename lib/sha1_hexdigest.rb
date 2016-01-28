require_relative 'processor'
require_relative 'preprocessor'

# Runner file for calculating the SHA-1 hexdigest for a user-provided message
# from the command line.
message = ARGV[0]

binary_message = Preprocessor.new.binary_message(message)
digest = Processor.new.hexdigest(binary_message)

puts "Your SHA-1 Hex Digest for the message '#{message}' is:"
puts digest
