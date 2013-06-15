require 'poker/hand_pair'

describe Poker::HandPair do
  describe "#to_s" do
    it "should join up the hand data 'first_hand vs second_hand'" do
      hands = [['1','2','3','4','5'], ['1','2','3','4','5']]
      hand_pair = Poker::HandPair.new hands
      hand_pair.to_s.should == '1 2 3 4 5 vs 1 2 3 4 5'
    end
  end
end
