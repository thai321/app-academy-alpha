
def ftoc(fahrenheit)
  celsius = (fahrenheit - 32.0)/(9.0/5)
  celsius.round
end

def ctof(celsius)
  fahrenheit = (celsius * 9.0/5) + 32
end
