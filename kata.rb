module Anagram
  def self.anagram?(string1, string2)
    string1.chars.sort == string2.chars.sort
  end

  def self.words
    @words ||= File.readlines("dictionary_full.txt").collect { |line| line.chomp.downcase } 
  end

  def self.two_word_anagrams_of(string)
    result = []

    candidate_words = words.select do |word|
      (word.chars.to_a - string.chars.to_a).empty?
    end

    candidate_words.each do |word1|
      candidate_words.each do |word2|
        if word2 <= word1 && anagram?(word1+word2, string)
          result << word1 + ' ' + word2
        end
      end
    end
    result
  end
end
