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
  end
end
