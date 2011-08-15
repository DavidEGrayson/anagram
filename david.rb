module Anagram
  def self.anagram_class(string)
    string.chars.sort.join
  end

  def self.anagram?(string1, string2)
    anagram_class(string1) == anagram_class(string2)
  end

  def self.words
    @words ||= File.readlines("dictionary_full.txt").collect { |line| line.chomp.downcase } 
  end

  def self.words_by_anagram_class
    @words_by_anagram_class ||= words.each_with_object(Hash.new []) do |word, hash|
      hash[anagram_class word] += [word]
    end
  end

  def self.each_partition(array, array1=[], array2=[], &block)
    if array.empty?
      # array has been fully partitioned in to array1 and array2
      yield array1, array2
    else
      # Try putting array[0] in to array1
      array1.push array.shift
      each_partition(array, array1, array2, &block)

      # Try putting array[0] in to array2
      array2.push array1.pop
      each_partition(array, array1, array2, &block)

      # Restore the arrays to their original values.
      array.unshift array2.pop
    end
  end
  
  def self.two_word_anagrams_of(string)
    result = []

    each_partition(string.chars.sort) do |letters1, letters2|
      # Get the anagram classes
      ac1 = letters1.join
      ac2 = letters2.join
      
      # Get the possible words
      words_by_anagram_class[ac1].each do |word1|
        words_by_anagram_class[ac2].each do |word2|
          if word2 <= word1
            result << word1 + ' ' + word2
          end
        end
      end
    end

    result.uniq
  end
end


