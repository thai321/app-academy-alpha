class Book
  # TODO: your code goes here!
    attr_accessor :title

    Special = {}; %w(the a an and of in).each { |word| Special[word] = 1 }

    def title
      func = lambda { |w, i| (Special[w] && i > 0) ? w : w.capitalize }
      @title.split.map.with_index { |w, i| func.call(w,i) }.join(' ')
    end

end
