require 'poker/hand_pair'

describe Poker::HandPair do
  describe ".new" do
    it "takes a pair of hands (array of arrays)" do
      Poker::HandPair.new([stub, stub])
    end
  end
end
