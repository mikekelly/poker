require 'poker/hand_pair'

describe Poker::HandPair do
  describe "#to_s" do
    it "should join up the hand data 'first_hand vs second_hand'" do
      hands = [['1','2','3','4','5'], ['1','2','3','4','5']]
      hand_pair = Poker::HandPair.new hands, hand_factory: stub
      hand_pair.to_s.should == '1 2 3 4 5 vs 1 2 3 4 5'
    end
  end

  describe "#winner" do
    it "returns the first hand if its greater than the second" do
      first_hand = mock(:first_hand)
      hand_factory = mock(:hand_factory)

      second_hand = stub
      hand_data_stubs = [stub, stub]

      hand_factory.should_receive(:call).with(hand_data_stubs[0]).and_return(first_hand)
      hand_factory.should_receive(:call).with(hand_data_stubs[1]).and_return(second_hand)

      first_hand.should_receive(:>).with(second_hand).and_return(true)

      pair = Poker::HandPair.new(hand_data_stubs, hand_factory: hand_factory)
      pair.winner.should == first_hand
    end

    it "returns the first hand if its greater than the second" do
      first_hand = mock(:first_hand)
      second_hand = mock(:second_hand)

      hand_factory = mock(:hand_factory)
      hand_data_stubs = [stub, stub]

      hand_factory.should_receive(:call).with(hand_data_stubs[0]).and_return(first_hand)
      hand_factory.should_receive(:call).with(hand_data_stubs[1]).and_return(second_hand)

      first_hand.should_receive(:>).with(second_hand).and_return(false)
      second_hand.should_receive(:>).with(first_hand).and_return(true)

      pair = Poker::HandPair.new(hand_data_stubs, hand_factory: hand_factory)
      pair.winner.should == second_hand
    end

    it "returns a NullHand if neither is the winner" do
      first_hand = mock(:first_hand)
      second_hand = mock(:second_hand)
      hand_factory = mock(:hand_factory)

      hand_data_stubs = [stub, stub]

      hand_factory.should_receive(:call).with(hand_data_stubs[0]).and_return(first_hand)
      hand_factory.should_receive(:call).with(hand_data_stubs[1]).and_return(second_hand)

      first_hand.should_receive(:>).with(second_hand).and_return(false)
      second_hand.should_receive(:>).with(first_hand).and_return(false)

      pair = Poker::HandPair.new(hand_data_stubs, hand_factory: hand_factory)
      pair.winner.should be_a Poker::NullHand
    end
  end
end
