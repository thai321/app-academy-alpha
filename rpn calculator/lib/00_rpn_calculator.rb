require 'byebug'

class RPNCalculator
  # TODO: your code goes here!
  attr_accessor :value

  def initialize
      @arr = []
      @value = 0
  end

  def push(num)
    @arr << num
  end

#------------ operations ------------
  def plus
    error if empty
    @arr << @arr.pop + @arr.pop
    @value = @arr.last
  end

  def minus
    error if empty
    @arr << -(@arr.pop - @arr.pop)
    @value = @arr.last
  end

  def times
    error if empty
    @arr << @arr.pop * @arr.pop
    @value = @arr.last
  end

  def divide
    error if empty
    @arr << 1.0/(@arr.pop.to_f / @arr.pop.to_f)
    @value = @arr.last
  end

#------------ checking methods ------------
  def empty
     @arr.empty?
  end

  def error
    raise "calculator is empty"
  end


#------------ extra credit ------------
  def tokens(string)
    string.split.map { |ch| (ch =~ /\d/) ? ch.to_i : ch.to_sym }
  end

  def evaluate(string)
    stack = tokens(string)
    stack.each do |el|
      case el
      when :+
        plus
      when :-
        minus
      when :*
        times
      when :/
        divide
      else
        push(el)
      end
    end

    @value
  end

end
