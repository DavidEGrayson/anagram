#!/usr/bin/env ruby
require_relative ENV['ALGORITHM'] || 'kata'
result = Anagram.two_word_anagrams_of("documenting")
result = result.collect{|x| x.split(' ').sort{|a,b| a.length <=> b.length}.join(' ')}
correct = (result.sort == ["dingo centum", "doing centum", "dung centimo", "dunting come", "genomic dunt", "guid contemn", "gunmen dicot", "induct genom", "induct gnome", "mendigo cunt", "meno ducting", "mignon educt", "mount ceding", "munting code", "munting coed", "munting deco", "mute condign", "muted coning", "muting coden", "muting coned", "muton ceding", "nome ducting", "nonce midgut", "notum ceding", "omen ducting", "omening duct", "tonemic dung", "tonged cumin", "tonged mucin", "tongmen duci", "tuned coming", "tuned gnomic", "tung demonic", "ungot minced", "unmet coding"].collect{|x| x.split(' ').sort{|a,b| a.length <=> b.length}.join(' ')}.sort)

if !correct
  puts "FAILED"
  puts result.inspect
  exit 1
end

puts "Success"
