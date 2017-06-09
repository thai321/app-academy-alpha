require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player, :hit, :miss

  def initialize(player = HumanPlayer.new, board = Board.new)
    @player = player
    @board = board
    @hit = false
    @miss = false
  end

  def attack(pos)
    if @board[pos] == :x
      @hit, @miss = false, false
    elsif @board[pos] == :s
      @hit = true; @miss = false
    else #  the board is avaliabe --> nil,  @board.empty?(pos)
      @miss = true; @hit = false
    end

    @board[pos] = :x
  end

  def count
    @board.count
  end

  def game_over?
    @board.won?
  end
  def play_turn
    pos = @player.get_play
    @board.in_range?(pos) ? attack(pos) : play_turn
  end

  def play
    puts "Welcome to the Battleship game!"
    @board.populate_grid

    while !game_over?
      @board.display; puts "There are #{@board.count} ships remaining."
      play_turn
      if @hit # hit a ship --> hit :s
        puts "You sunk a ship!\n\n"
      elsif !@miss && !@hit ## hit the old location :x
        puts "You've already fired that location\n\n"
      else # miss --> hit nil
        puts "Miss!\n\n"
      end
    end
    puts "You Won!"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = BattleshipGame.new; game.play
end
