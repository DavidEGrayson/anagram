#!/usr/bin/env ruby
require_relative ENV['ALGORITHM'] || 'kata'
result = Anagram.two_word_anagrams_of("documenting")
result = result.collect{|x| x.split(' ').sort.join(' ')}.sort

correct = (result == ["ceding mount", "ceding muton", "ceding notum", "centimo dung", "centum dingo", "centum doing", "code munting", "coden muting", "coding unmet", "coed munting", "come dunting", "coming tuned", "condign mute", "coned muting", "coning muted", "contemn guid", "cumin tonged", "cunt mendigo", "deco munting", "demonic tung", "dicot gunmen", "duci tongmen", "duct omening", "ducting meno", "ducting nome", "ducting omen", "dung tonemic", "dunt genomic", "educt mignon", "genom induct", "gnome induct", "gnomic tuned", "midgut nonce", "minced ungot", "mucin tonged"])

if !correct
  puts "FAILED"
  puts result.inspect
  exit 1
end

puts "Success"
