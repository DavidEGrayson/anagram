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

  # NOTE: This function will typically do nothing because @words_by_anagram_class
  # will be populated in david_data.rb.
  def self.words_by_anagram_class
    @words_by_anagram_class ||= words.each_with_object(Hash.new []) do |word, hash|
      hash[anagram_class word] += [word]
    end
  end

  def self.prepare
    File.open('david_data.rb', 'w') do |file|
      file.write <<END
module Anagram
@w = @words_by_anagram_class = Hash.new([])
END

      words_by_anagram_class.each do |ac, words|
        file.write "@w[#{ac.inspect}] = #{words.inspect}\n" 
      end

      file.write <<EOF
end
EOF
    end
  end

  def self.each_partition(array, array1=[], array2=[], &block)
    if array.empty?
      # array has been fully partitioned in to array1 and array2
      yield array1, array2
    else
      # Try putting array[0] in to array1
      array1.push array.shift
      each_partition array, array1, array2, &block

      # Try putting array[0] in to array2
      array2.push array1.pop
      each_partition array, array1, array2, &block

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
  # TODO: We have to call uniq at the end because documenting
  # has two 'n's.  Try to make the algorithm smarter so we don't
  # have to call uniq and see if it gets faster.
end

begin
  require_relative 'david_data'
rescue LoadError
  puts "Preparing david_data.rb.  Next time this will be faster."
  Anagram.prepare
  require_relative 'david_data'
end

