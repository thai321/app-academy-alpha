require 'byebug'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :board, :current_player

  def initialize(player_one, player_two)
    @board = Board.new
    @current_player = player_one
    @player_one, @player_two  = player_one, player_two
  end

  def play_turn
    move_pos = @current_player.get_move
    @board.place_mark(move_pos, @current_player.mark)
    switch_players!
  end

  def switch_players!
    @current_player = (@current_player == @player_one)? @player_two : @player_one
  end

  def play
    puts "Welcome to the Tic Tac Toe game!" ; #@current_player.display(@board)
    (@board.display; play_turn) while !@board.over?

    puts "Final board:"; @board.display

    if @board.tied? then puts "Tied!"
    else
      winner = (@player_one.mark == @board.winner)? @player_one : @player_two
      puts "The winner is #{winner.name}"
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  human = HumanPlayer.new("Thai"); human.mark = :X
  computer = ComputerPlayer.new("D-Square"); computer.mark = :O
  game = Game.new(human, computer); computer.display(game.board)
  game.play # computer's board need to set to the game since human is the first player
end
