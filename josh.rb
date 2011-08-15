module Anagram
  def self.anagram?(string1, string2)
    string1.chars.sort == string2.chars.sort
  end

  def self.words
    @words ||= File.readlines("dictionary_full.txt").collect { |line| line.chomp }
  end

	def self.cross_product(a1, a2)
		return [] if a1.nil? or a2.nil?
		result = []
			a1.each do |x|
				a2.each do |y|
					result << "#{x} #{y}"
				end
			end
		result
	end

	def self.sub_anagram(string1, string2)
		s1_pos, s2_pos = 0, 0
		leftovers = ''
		while string2.length > s2_pos 
			if string1[s1_pos] == string2[s2_pos]
				s1_pos+=1
				s2_pos+=1				
			else
				leftovers+=string2[s2_pos,1][0].to_s
				s2_pos+=1
			end
			return [true, "#{string1.join}_#{leftovers}#{string2[s2_pos,string2.length-s2_pos].join}"] if s1_pos >= string1.length
		end
		return [false, '']
	end

	def self.candidate_words(string)
		sorted_words = {}
		words.each do |word|
			next if word.length >= string.length or string.index(word[0].chr).nil? or string.index(word[1].chr).nil? or string.index(word[2].chr).nil?
			sorted = word.chars.sort
			is_sub, leftovers = sub_anagram(sorted, string.chars.sort)
			if is_sub
				joined = sorted.join
				if sorted_words[leftovers]
					sorted_words[leftovers] << word
				else
					sorted_words[leftovers] = [word]
				end
			end	
		end
		sorted_words
	end

  def self.two_word_anagrams_of(string)
		result = []		
		string = string.upcase
		words = candidate_words(string)
		words.keys.each do |key|
			#puts key
			split = key.split('_')
			next if split[0].length > string.length / 2
			result = result + cross_product(
				words[key],
				words[split[1]+'_'+split[0]])
		end
    result.collect {|x| x.downcase}
  end
end
