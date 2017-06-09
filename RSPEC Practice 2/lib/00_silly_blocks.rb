def reverser(&block)
  block.call.split.map {|word| word.reverse}.join(' ')
end

def adder(increment=1, &block)
  block.call + increment
end

def repeater(repeat_time=1, &block)
  repeat_time.times { block.call }
end
