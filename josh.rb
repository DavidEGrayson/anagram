module Anagram
  def self.words(target_sorted)
		@words = []
		File.open('dictionary_full.txt','r') do |file|
			start_char = target_sorted.first
			end_char = target_sorted.last
			while file.readline()[0] < start_char; end
			while (t=file.gets)
				@words << t.chomp
			end
		end
		@words
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
				leftovers+=string2[s2_pos,1][0]
				s2_pos+=1
			end
			return [true, string1.join + '_' + leftovers + string2[s2_pos,string2.length-s2_pos].join] if s1_pos >= string1.length		
		end
		return [false, '']
	end
	def self.candidate_words(string)
		sorted_words = {}
		s = string.chars.sort
		words(s).each do |word|			
			next if word.length >= string.length or string.index(word[0]).nil? or string.index(word[1]).nil? or string.index(word[2]).nil?
			sorted = word.chars.sort
			is_sub, leftovers = sub_anagram(sorted, s)
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
		half = string.length / 2 
		words.keys.each do |key|
			#puts key
			split = key.split('_')
			next if split[0].length > half
			result = result + cross_product(
				words[key],
				words[split[1]+'_'+split[0]])
		end
    result.collect {|x| x.downcase}
  end
end

