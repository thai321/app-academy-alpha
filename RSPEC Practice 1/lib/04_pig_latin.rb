
def translate(sentence)
	result = []

	sentence.split.each do |word|
		result << latinize(word)
	end

	result.join(" ")
end

def latinize(word)
  i = word.include?("qu")? word.index(/[aeioAEIO]/) : word.index(/[aeiouAEIOU]/)
  temp = word[i..-1] + word[0...i] + "ay"
  result = word[0] == word[0].upcase ? temp.capitalize : temp
end
