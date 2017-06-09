
def echo(word)
  word
end

def shout(words)
  words.upcase
end

def repeat(word, num=2)
  ([word] * num).join(' ')
end

def start_of_word(s,i)
  s[0...i]
end

def first_word(s)
  s.split.first
end

def titleize(s)
  ignore = ["the", "and", "over"]
  result = s.split.map do |word|
    if !ignore.include?(word)
      word.capitalize!
    else
      word
    end
  end
  result[0].capitalize!
  result.join(' ')
end
