require 'byebug'
class Hangman
  attr_reader :guesser, :referee, :board, :misses

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @guesses = 10
    @misses = []
  end

  def setup
    len = @referee.pick_secret_word
    @guesser.register_secret_length(len)
    @board = "-" * len
  end

  def take_turn
    puts "Misses: #{@misses}"

    letter = @guesser.guess(board);
    if @board.include?(letter) || @misses.include?(letter)
      puts "Already guess\n\n"
      return take_turn
    end

    @guesses -=1
    indices = @referee.check_guess(letter); update_board(letter, indices)
    @misses << letter if indices.empty?
    @guesser.handle_response(letter, indices)

    puts ""
    p @board
    puts "\n"
  end

  def update_board(letter, indices)
    indices.each { |i| @board[i] = letter }
  end

  def win?
    @board.chars.none? { |ch| ch == "-"}
  end

  def play
    "Welcome to the Hangman game!"
    while (@guesses > 0) && !win?
      puts "You have #{@guesses} remaining"
      take_turn
    end

    if win? then puts "You won! The secret word is #{@referee.secret}"
    else
      puts "Out of guesses! The secret word is #{@referee.secret}"
    end
  end

end

class HumanPlayer
  attr_reader :name, :secret_length, :guess

  def initialize(name = "Thai")
    @name = name
  end

  def pick_secret_word
    puts "Pick a secret word, tell us how long is it? (ex: \"5\")"
    begin
      len = gets.chomp.to_i
    rescue ArgumentError
      puts "Please enter a valid length"
      retry
    end
  end

  def register_secret_length(length)
    @secret_length = length
  end

  def guess(board)
    p board
    puts "Please guess a letter (ex: \"d\"):"
    @guess = gets.chomp
  end

  def handle_response(letter, indices)
    if indices.empty?
      puts "Sorry, no match!"
    else
      print "Found #{letter} at positions "
      indices.each { |i| print "#{i} " }; print "\n"
    end
 end

end

class ComputerPlayer
  attr_reader :dictionary, :secret
  attr_accessor :candidate_words

  def initialize(dictionary)
      @dictionary = dictionary
      @secret = ""
      @candidate_words = dictionary
  end

  def pick_secret_word
    @secret = @dictionary.sample; size
  end

  def check_guess(guess)
    (0...size).select { |i| @secret[i] == guess }
  end

  def register_secret_length(num)
    @candidate_words.select! { |word| word.length == num }
  end

  def handle_response(guess, indices)
    if indices.empty? then no_indices(guess)
    else
      @candidate_words.select! do |word|
        (indices.all? { |i| word[i] == guess }) &&
        (word.count(guess)) <= indices.length
      end
    end
  end

  def guess(board)
    freq = Hash.new(0)
    @candidate_words.each { |word| word.chars { |ch| freq[ch] += 1 }}
    freq_sort = freq.sort_by { |k, v| v } # return an sort array by value

    common_word = freq_sort.pop.first   # else return remainning most common word
    (board.all? { |ch| ch.nil? }) ? common_word : freq_sort.last.first
  end# board is all nil -> when no guesses -> return most common letter

  def no_indices(guess)
    @candidate_words.reject! { |word| word.include?(guess) }
  end

  def size
    @secret.length
  end

end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("lib/dictionary.txt")
  dictionary.map!{|line| line.chomp}

  dd = ComputerPlayer.new(dictionary); thai = HumanPlayer.new
  players = { referee: dd, guesser: thai }

  game = Hangman.new(players);
  game.setup
  game.play
end
