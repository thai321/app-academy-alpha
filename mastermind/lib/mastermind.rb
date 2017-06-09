require 'byebug'
class Code
  attr_reader :pegs
  PEGS = {'B' => 'Blue', 'G' => 'GREEN', 'O' =>'Orange',
    'P' => 'Purple', 'R' => 'RED', 'Y' => 'YELLOW'}

  def initialize(pegs)
    @pegs = pegs
  end

  def self.parse(code)
    raise "Invalid color(s)" if code.chars.any? { |ch| !PEGS[ch.upcase] }
    Code.new(code.chars.map(&:upcase))
  end

  def self.random
    random_pegs = "";  4.times { random_pegs += PEGS.keys.sample }
    Code.new(random_pegs.chars)
  end

  def [](i)
    @pegs[i]
  end

  def exact_matches(other_code)
    (0..3).map { |i| (self[i] == other_code[i]) ? 1 : 0 }.reduce(:+)
  end

  def near_matches(other_code)
    inter_set = (self[0..-1].uniq) & (other_code[0..-1].uniq)
    (inter_set.size - exact_matches(other_code)).abs
  end

  def ==(object)
    (object.is_a? Code) && (exact_matches(object) == 4)
  end

end

class Game
  attr_reader :secret_code, :guesses

  def initialize(code = Code.random)
    @secret_code = code
    @guesses = 10
  end

  def get_guess
    puts "Please enter a code (ex: \"bryo\"):" ; ARGV.clear
    @guesses -= 1
    begin code = gets.chomp; Code.parse(code)
    rescue
      puts "Invalid code, please enter a code (ex: \"bryo\"):"; get_guess
    end
  end

  def display_matches(code)
    exact = @secret_code.exact_matches(code)
    near = @secret_code.near_matches(code)
    puts "exact: #{exact}, near: #{near}, remaining guesses = #{@guesses}\n\n"
  end

  def play
    win = false

    while (@guesses > 0) && !win
      code = get_guess; display_matches(code)
      win = true if (@secret_code.exact_matches(code) == 4)
    end
    puts "The Secret code was #{@secret_code[0..3].join}"
    puts win ? "You win!!!" : "You lose :("
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new; game.play
end
