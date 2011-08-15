module Anagram
  def self.two_word_anagrams_of(string)
		result = []		
		matches, target = {}, {}
		string.upcase.each_byte {|b| target[b] = (target[b] or 0)+1}
		File.readlines('dictionary_full.txt').each do |word|			
			word.chop!
			next if word.length > string.length
			bad = false
			wh = {}
			word.each_byte do |k|
				if target[k].nil? or ((wh[k] = (wh[k] or 0)+1) > target[k])
					bad = true
					break
				end
			end	
			next if bad
			diff = {}
			target.keys.each do |key|
				count = target[key] - (wh[key] or 0)
				diff[key] = count if count > 0
			end
			if ms = matches[diff]	
				ms.each {|m| result << "#{m} #{word}"} 
			end
			(matches[wh] ||= []) << word
		end	
    result.collect {|x| x.downcase}
  end
end
