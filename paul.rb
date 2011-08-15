module Anagram
  @@zeros = 26.times.collect {0}
  
  def self.to_vector_array(word)
    array = @@zeros.dup
    word.each_byte { |x| array[x-65] += 1}
    array
  end

  def self.two_word_anagrams_of(string)
    s = string.upcase
    target = to_vector_array(s)

    vec_hash = {}
    ret = []
    diff = Array.new(26)

    open('dictionary_full.txt','rb').each do |word|
      word.chop!

      bad = false
      word.each_byte do |x|
        if target[x-65] == 0
          bad = true
          break
        end
      end
      next if bad
      next if word.length > string.length - 4

      vec = to_vector_array(word)
      26.times do |i|
        target[i] - vec[i]
      end

      if others = vec_hash[diff]
        others.each do |other_word|
          ret << "#{other_word} #{word}".downcase
        end
      end
      (vec_hash[vec] ||= []) << word
    end

    ret
  end
end
