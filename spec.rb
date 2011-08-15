require_relative ENV['ALGORITHM'] || 'kata'

describe "Anagram.anagram?" do
  context "given two equal strings" do
    it "returns true" do
     Anagram.anagram?("ruby", "ruby").should == true
    end
  end

  context "given two strings that are not anagrams" do
    it "returns false" do
      Anagram.anagram?("ruby", "buddy").should == false
    end
  end

  context "given two strings that are anagrams" do
    it "returns true" do
      Anagram.anagram?("ruby", "bury").should == true
    end
  end
end

describe "Anagram.words" do
  it "is an array" do
    Anagram.words.should be_a_kind_of Array
  end
end

describe "Anagram.two_word_anagram_of" do
  context "given an empty string" do
    it "should return an empty array" do
      Anagram.two_word_anagrams_of("").should == []
    end
  end

  context "given the string 'documenting'" do
    before(:all) do
      @result = Anagram.two_word_anagrams_of('documenting')
      @result = @result.collect{|x| x.split(' ').sort.join(' ')}.sort
    end

    it "includes 'coding unmet'" do
      @result.should include 'coding unmet'
    end

    it "does not include 'unmet coding'" do
      @result.should_not include 'unmet coding'
    end

    it "returns all the two word anagrams of documenting" do
      @result.should == ["ceding mount", "ceding muton", "ceding notum", "centimo dung", "centum dingo", "centum doing", "code munting", "coden muting", "coding unmet", "coed munting", "come dunting", "coming tuned", "condign mute", "coned muting", "coning muted", "contemn guid", "cumin tonged", "cunt mendigo", "deco munting", "demonic tung", "dicot gunmen", "duci tongmen", "duct omening", "ducting meno", "ducting nome", "ducting omen", "dung tonemic", "dunt genomic", "educt mignon", "genom induct", "gnome induct", "gnomic tuned", "midgut nonce", "minced ungot", "mucin tonged"]
    end
  end
end
