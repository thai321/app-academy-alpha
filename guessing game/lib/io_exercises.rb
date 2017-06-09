require 'byebug'
# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  number = rand(1..100); count = 0; won = false

  puts "Welcome to the Guessing name!"
  while !won
    puts "Please guess a number: "; guess = gets.chomp.to_i ; count += 1
    if (guess == number) then won = true else
      output = guess > number ? "too high" : "too low"
      print "Your guessed is #{guess}, #{output}.\n\n"
    end
  end
  puts "You won! the number was #{number} with #{count} guesses."

end

def hello
  puts "Hello World"
end

if __FILE__ == $PROGRAM_NAME
  # sleep 10
  byebug
  # puts "file =  #{__FILE__}"
  # puts "$PROGRAM_NAME = #{$PROGRAM_NAME}"
  hello
  # puts "Please enter a file name:"
  # file_name = gets.chomp
  # contents = File.readlines(file_name).shuffle
  #
  # File.open("#{file_name[0...-4]}-shuffled.txt", "w") do |f|
  #   contents.each { |line| f.puts line }
  # end
end
puts "file =  #{__FILE__}"
puts "$PROGRAM_NAME = #{$PROGRAM_NAME}"
