class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    min, sec = @seconds.divmod(60)
    hr, min = min.divmod(60)
    f = lambda { |x| sprintf '%02d', x }
    f.call(hr) + ":" + f.call(min) + ":" + f.call(sec)
  end
end
