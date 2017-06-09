class ComputerPlayer
  attr_accessor :board, :mark
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def display(board) # display method in Board class
    @board = board;
  end

  def get_move
    arr = []; m = @board.grid.length - 1; n = @board.grid[0].length - 1
    (0..m).each {|i| (0..n).each {|j| arr << [i,j] if @board.grid[i][j].nil? }}
                        # get all the points that is nil to array arr
    arr.each do |pos|  # Check all the points to see whether a winning mark
      return pos if @board.place_mark(pos, @mark) && (@board.winner == @mark)
      set_nil(pos)
    end
    return arr.sample
  end

  private
  def set_nil(pos)
    @board.grid[pos[0]][pos[1]] = nil
  end
end
