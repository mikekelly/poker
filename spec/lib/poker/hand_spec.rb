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

    it "when the category rank is the same, it wraps itself in the category class and asks that instead" do
      category = mock(:category)
      categorised_hand = mock(:categorised_hand)
      categorised_other = stub

      hand = Poker::Hand.new stub, category: category
      other_hand = Poker::Hand.new stub, category: category

      category.should_receive(:new).with(hand).and_return(categorised_hand)
      category.should_receive(:new).with(other_hand).and_return(categorised_other)
      categorised_hand.should_receive(:>).with(categorised_other).and_return(true)

      (hand > other_hand).should be_true
    end
  end
end
