require 'byebug'
class Dictionary
  # TODO: your code goes here!
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(entry)
    if entry.is_a? Hash
      @entries.merge!(entry)
    else
      @entries[entry] = nil
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(key)
    @entries.include?(key)
  end

  def find(entry)
    match = {}
    keywords.each { |k| match[k] = @entries[k] if k.include?(entry) }
    match
  end

  def printable
    result = ""
    keywords.each { |k| result += "[#{k}] \"#{@entries[k]}\"\n" }
    result.chomp
  end

end
