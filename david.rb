module Anagram
  DataFilename = 'david_data.txt'

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
  # will be populated by load_data.
  def self.words_by_anagram_class
    @words_by_anagram_class ||= words.each_with_object(Hash.new []) do |word, hash|
      hash[anagram_class word] += [word]
    end
  end

  def self.load_data
    w = @words_by_anagram_class = Hash.new([])
    File.readlines(DataFilename).each do |line|
      ac, words = line.split(':')
      w[ac] = words.split(',')
    end
  end

  def self.create_data
    File.open DataFilename, 'w' do |file|
      words_by_anagram_class.keys.sort.each do |ac|
        file.puts ac + ':' + words_by_anagram_class[ac].join(',')
      end
    end
  end

  def self.create_and_load_data
    if File.exist? DataFilename
      load_data
    else
      puts "Preparing #{DataFilename}.  Next time this will be faster."
      Anagram.create_data
    end
  end

  def self.each_partition(array, array1=[], array2=[], &block)
    if array.empty?
      # array has been fully partitioned into array1 and array2
      yield array1, array2
    else
      # Try putting array[0] into array1
      array1.push array.shift
      each_partition array, array1, array2, &block

      # Try putting it into array2
      array2.push array1.pop
      each_partition array, array1, array2, &block

      # Restore the arrays to their original values.
      array.unshift array2.pop
    end
  end
  
  def self.two_word_anagrams_of(string)
    result = []

    each_partition(string.chars.sort) do |sorted_letters1, sorted_letters2|
      # Get the anagram classes
      ac1 = sorted_letters1.join
      ac2 = sorted_letters2.join
      
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

Anagram.create_and_load_data
