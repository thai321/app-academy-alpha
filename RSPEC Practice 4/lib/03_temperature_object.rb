class Temperature
  # TODO: your code goes here!
    attr_accessor :celsius, :fahrenheit

    def initialize(hash_entry = {})
      @celsius = hash_entry[:c]
      @fahrenheit = hash_entry[:f]
    end

    def in_fahrenheit
      @fahrenheit.nil? ? Temperature.ctof(celsius) : @fahrenheit
    end

    def in_celsius
      @celsius.nil? ? Temperature.ftoc(fahrenheit) : @celsius
    end

#------------------ class methods: ftoc and ctof-------------
    def self.ftoc(temp)
      (temp - 32)*(5.0/9)
    end

    def self.ctof(temp)
      (temp * 9.0/5) + 32
    end

#------------------ factory methods ------------------------
    def self.from_celsius(temp)
      Temperature.new(:c => temp)
    end

    def self.from_fahrenheit(temp)
      Temperature.new(:f => temp)
    end

end
#------------------ end Temperature class#------------------


#------------------ Subclasses ------------------------
class Celsius < Temperature
    def initialize(temp)
      super(:c => temp)
    end
end

class Fahrenheit < Temperature
    def initialize(temp)
      super(:f => temp)
    end
end
