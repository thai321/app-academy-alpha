class HumanPlayer
  attr_reader :name

  def initialize(name = "Thai")
    @name = name
  end

  def get_play
    print "Please enter a valid position"
    print "(ex: \"d 5\" or \"D 5\"):\n"; input = gets.chomp
    tranlate(input.split)
  end

  def tranlate(pos)
    x = pos[1].to_i
    y = ('A'..'J').to_a.index(pos[0].upcase)
    [x,y]
  end
end
