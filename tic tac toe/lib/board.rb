require 'byebug'
class Board
  attr_reader :grid

  def initialize(grid = multi_grid(3,3))
    @grid = grid
  end

  def multi_grid(n,m) (Array.new(n) { Array.new(m) }) end

  def place_mark(pos, mark)
    @grid[pos[0]][pos[1]] = mark
  end

  def empty?(pos)
    get_point(pos) == nil
  end

  def winner
    return row_col || diagonal_left_right
  end

  def over?
    !(winner.nil?) || tied?
  end


  def display
    puts ""
    @grid.each do |row|
      row.each { |el| print !(el.nil?) ? " #{el} | " : "   | " }
      puts "\n--------------"
    end
    puts "\n##############\n\n"
  end


#--------- Below methods are helper classes
  def get_point(pos)
    @grid[pos[0]][pos[1]]
  end

#----------- Helper for winner method : row_col and diagonal_left_right --------
  def row_col
    f = lambda do |board ,mark|
      board.any? { |row| row.all? {|cell| cell == mark } } end

    return :X if (f.call(@grid ,:X) || f.call(@grid.transpose,:X))
    return :O if (f.call(@grid ,:O) || f.call(@grid.transpose,:O))
  end                               # tranpose is for column check

  def diagonal_left_right
    func = lambda do |arr, mark|
      return mark if arr.all? { |el| el == mark } end

    left = []; len = @grid.length
    (0...len).each { |i| left << @grid[i][i] }

    right = []; len = @grid.length - 1
    (0...@grid.length).each { |i| right << @grid[i][len-i] }

    return :X if (func.call(left, :X) == :X) || (func.call(right, :X) == :X)
    return :O if (func.call(left, :O) == :O) || (func.call(right, :O) == :O)
  end

#------------- Helpe for over? method
  def tied?
    @grid.all? { |row| row.all? { |el| el != nil } }
  end # if all of row of all of el in each row is not nil, then tie

end
