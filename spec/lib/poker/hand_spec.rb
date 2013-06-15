require 'poker/hand'

describe Poker::Hand do
  describe "#category_rank" do
    it "returns the rank of the hands category" do
      hand = Poker::Hand.new stub, category: Poker::Categories::HighCard
      hand.category_rank.should == 0

      other_hand = Poker::Hand.new stub, category: Poker::Categories::Pair
      other_hand.category_rank.should == 1
    end
  end

  describe "# >" do
    it "returns true if the category rank is greater than the supplied hand" do
      hand = Poker::Hand.new stub, category: Poker::Categories::HighCard
      other_hand = Poker::Hand.new stub, category: Poker::Categories::Pair

      (hand > other_hand).should be_false
    end
  end
end
