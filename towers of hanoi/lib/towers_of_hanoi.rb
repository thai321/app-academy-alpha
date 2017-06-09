# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.
require 'byebug'
class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1],[],[]]
  end

  def move(from, to)
    @towers[to] << @towers[from].pop
  end

  def valid_move?(from, to)
    return false if (@towers[from].empty?)
    return true if (from == to) || (@towers[to].empty?)
    return (@towers[from].last < @towers[to].last) ? true : false
  rescue NoMethodError ; puts "Wrong pile!"
  end

  def won?
    @towers[1..2].any? { |tower| tower.size == 3 }
  end

  def play
    puts "Welcome to the game towers of Ha Noi."
    puts "There are 3 piles: 0, 1, 2"
    render

    until won?
      from, to = input
      if valid_move?(from, to) then move(from, to)
      else puts "Invalid move, please try again"; render; next end
      render
    end

    puts "You Won!!!"
  end

  def input
    puts "Please select a dics from a pile, which pile? 0, 1, or 2"
    from = gets.chomp.to_i
    puts "Please select a pile to place a disk, which pile? 0, 1, or 2"
    to = gets.chomp.to_i
    [from, to]
  end

  def render
    p @towers
    print "\n"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = TowersOfHanoi.new
  game.play
end
