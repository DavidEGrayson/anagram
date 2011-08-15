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
    end

    it "includes 'unmet coding'" do
      @result.should include 'unmet coding'
    end

    it "does not include 'coding unmet'" do
      @result.should_not include 'coding unmet'
    end

    it "returns all the two word anagrams of documenting" do
      @result.sort.should == ["dingo centum", "doing centum", "dung centimo", "dunting come", "genomic dunt", "guid contemn", "gunmen dicot", "induct genom", "induct gnome", "mendigo cunt", "meno ducting", "mignon educt", "mount ceding", "munting code", "munting coed", "munting deco", "mute condign", "muted coning", "muting coden", "muting coned", "muton ceding", "nome ducting", "nonce midgut", "notum ceding", "omen ducting", "omening duct", "tonemic dung", "tonged cumin", "tonged mucin", "tongmen duci", "tuned coming", "tuned gnomic", "tung demonic", "ungot minced", "unmet coding"].sort
    end
  end
end
