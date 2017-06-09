require 'byebug'
class Board
  attr_accessor :grid

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def self.default_grid(m = 10,n = 10) (Array.new(m) { Array.new(n) }) end

  def count
    @grid.map { |row| row.count(:s) }.reduce(:+)
  end

  def empty?(pos = @grid)         # else check whether pos is avaliabe --> nil
    (pos == @grid) ? (count == 0) : (self[pos] != :s)
  end # pos = @grid -> check whether the board is empty (count = 0 --> no ship)

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, mark)
    @grid[pos[0]][pos[1]] = mark
  end

  def full?
    @grid.all? { |row| row.none? { |el| el == nil } }
  end

  def place_random_ship
    raise "The board is full" if full?

    x, y = rand(@grid.length), rand(@grid[0].length);
    until empty?([x, y])
      x, y = rand(@grid.length), rand(@grid[0].length);
    end
    @grid[x][y] = :s;
  end

  def won?
    count == 0
  end

  def populate_grid
    rand(@grid.length * @grid[0].length).times { place_random_ship }
  end

  def in_range?(pos)
    pos.all? { |x| (x >= 0 && x < 10) }
  end

  def display
    puts "     "  + ('A'..'J').to_a.join('   ')
    @grid.each_with_index do |row, i|
      print "#{i}: "
      row.each do |el|
        print (el != nil) ? "| #{el} " : "|   "
      end
      print "|\n--------------------------------------------\n"
    end
  end

end
