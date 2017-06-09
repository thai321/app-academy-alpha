class HumanPlayer
  attr_accessor :board, :mark
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Where do you want to place? ex: \"x, y\""
    input = gets.chomp
    pos = [input[0].to_i, input[-1].to_i]
  end

  def display(board) # display method in Board class
    @board = board; @board.display
  end
end
