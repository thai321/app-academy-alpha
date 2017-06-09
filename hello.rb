require 'byebug'
def hello
    puts "Inside Hello, World"
    puts "Hello, world!"
    byebug
    puts "$PROGRAM_NAME = #{$PROGRAM_NAME}"
    puts "$0            = #{$0}"
    puts "__FILE__      = #{__FILE__}"
end


puts "Outside hello function"
puts "$PROGRAM_NAME = #{$PROGRAM_NAME}"
puts "$0            = #{$0}"
puts "__FILE__      = #{__FILE__}"

puts "Call hello fuction"
hello
