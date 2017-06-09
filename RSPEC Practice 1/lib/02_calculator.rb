
def add(x,y)
  x+y
end

def subtract(x,y)
  x-y
end

def sum(arr)
  arr.reduce(0,:+)
end


def multiply(*args)
  args.map(&:to_i).reduce(1,:*)
end

def power(num,power)
  num**power
end

def factorial(num)
  return 1 if num == 0
  (1..num).to_a.reduce(1,:*)
end
