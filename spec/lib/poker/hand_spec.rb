require 'poker/hand'

describe Poker::Hand do
  describe "#category_rank" do
    it "returns the rank of the hands category" do
      hand = Poker::Hand.new stub, category: Poker::Categories::HighCard, card_factory: stub
      hand.category_rank.should == 0

      other_hand = Poker::Hand.new stub, category: Poker::Categories::Pair, card_factory: stub
      other_hand.category_rank.should == 1
    end
  end

  describe "# >" do
    it "returns true if the category rank is greater than the supplied hand" do
      hand = Poker::Hand.new stub, category: Poker::Categories::HighCard, card_factory: stub
      other_hand = Poker::Hand.new stub, category: Poker::Categories::Pair, card_factory: stub

      (hand > other_hand).should be_false
    end

    it "when the category rank is the same, it wraps itself in the category class and asks that instead" do
      category = mock(:category)
      categorised_hand = mock(:categorised_hand)
      categorised_other = stub

      hand = Poker::Hand.new stub, category: category, card_factory: stub
      other_hand = Poker::Hand.new stub, category: category, card_factory: stub

      category.should_receive(:new).with(hand).and_return(categorised_hand)
      category.should_receive(:new).with(other_hand).and_return(categorised_other)
      categorised_hand.should_receive(:>).with(categorised_other).and_return(true)

      (hand > other_hand).should be_true
    end
  end

  describe "#cards" do
    it "returns each of the hands via the card factory" do
      card_stubs = [stub,stub]
      card_factory = mock(:card_factory)
      cards = [mock(:first_card), mock(:second_card)]

      card_stubs.each_with_index do |card_stub, i|
        card_factory.should_receive(:call).with(card_stub).and_return cards[i]
      end

      hand = Poker::Hand.new card_stubs, card_factory: card_factory
      hand.cards.should == cards
    end
  end
end
