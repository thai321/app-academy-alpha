require 'byebug'
# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  hash = {}
  str.split.each { |word| hash[word] = word.length }
  hash
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by { |k, v| v }.last.first
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  newer.each { |k, v| older[k] = v }
  older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  hash = Hash.new(0)
  word.chars.each { |ch|  hash[ch] += 1}
  hash
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  hash = {}
  arr.each { |el| hash[el] = 1 if !hash.has_key?(el) }
  hash.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  hash = Hash.new(0)
  numbers.each { |x| if x.odd? then hash[:odd] += 1 else hash[:even] += 1 end }
  hash
end

# Define a method that, given a string, returns the most common vowel. If
# there's a tie, return the vowel that occurs earlier in the alphabet. Assume
# all letters are lower case.
def most_common_vowel(string)
  # hash = Hash.new(0)
  # vowel = "aeiou"
  # string.chars.each { |ch| hash[ch] += 1 if vowel.include?(ch) }
  # hash.sort_by { |k, v| v }.last.first

  vowels = %w(a e i o u)
  counts = Hash.new(0) # Give the hash a default value of 0

  string.each_char do |character|
    counts[character] += 1 if vowels.include?(character)
  end

  counts.sort_by {|k, v| v}.last.first
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
  arr = []
  keys = students.select { |k,v| v >= 7 }.keys
  keys.each_with_index do |student, i|
    keys[(i + 1)..-1].each { |other| arr << [student, other] }
  end
  arr
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  hash = {}
  specimens.uniq.each { |k| hash[k] = specimens.count(k)}
  value_sort = hash.values.sort
  smallest, largest = value_sort.first, value_sort.last
  hash.count ** 2 * (smallest/largest)
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  hash = character_count(vandalized_sign)
  normal_sign.downcase!
  hash.each.none? { |k, v| (normal_sign.count(k) < v) }
end

def character_count(str)
  hash = {}
  str.delete(' ').downcase.chars.uniq { |ch| hash[ch] = str.count(ch) }
  hash
end
