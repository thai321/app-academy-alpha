require 'byebug'
class Fixnum

  OTHER = {
    1000000000000 => "trillion",
    1000000000 => "billion",
    1000000 => "million",
    1000 => "thousand",
    100 => "hundred"
    }
# ------------ 10, 20, 30, 40, 50, 60, 70, 80, 90 ----------------------
  tens = %w(ten twenty thirty forty fifty sixty seventy eighty ninety)
  TENS = {}
  (1..9).each { |i| TENS[i*10] = tens[i-1] }

# ---------------------- 11 -> 19 --------------------------------------
  teens = %w(ten eleven twelve thirteen fourteen fifteen
  sixteen seventeen eighteen nineteen)
  TEENS = {}
  (10..19).each { |i| TEENS[i] = teens[i-10] }

# ------------------------ 1 -> 9 --------------------------------------
  ones = %w(zero one two three four five six seven eight nine)
  ONES = {}
  (0..9).each { |i| ONES[i] = ones[i] }

# ------------------------ in_words --------------------------------------
  def in_words
    # get_words (helper method), get the number scale (ten,hundred,million,...)
    # divide into 2 branches: left and right. Middle point is the number scale
    # left + mid + scale
    get_words = lambda do |n|
      left = (self/(10**n)).in_words.chomp
      right = (" #{OTHER[10**n]} " + (self % (10**n)).in_words).chomp
      left + right
    end

    case self.to_s.length
    when 1
      return ONES[self]
    when 2
      if self < 20
        return TEENS[self]
      else
        left = TENS[(self / 10) * 10]
        right = (" " + ONES[self % 10]).chomp
        left + right
      end
    when 3
      left = ONES[self/10**2]
      right = (" #{OTHER[10**2]} " + (self % (10**2)).in_words).chomp
      left + right
    when 4..6
      get_words.call(3)
    when 7..9
      get_words.call(6)
    when 10..12
      get_words.call(9)
    when 13..15
      get_words.call(12)
    end
  end
end

# ------------------------ in_words --------------------------------------
class String
  def chomp # chomp out the zero with an extra space
    (self[-5,5] == " zero") ? self[0...-5] : self
  end
end
