require 'poker/line_parser'

describe Poker::LineParser do
  describe "#lines_to_hand_pairs" do
    it "splits up each line into arrays of cards and passes to hand pair factory" do
      lines = [
        '2H 3H 4D 6S 7S vs 2H 3H 4D 6S AS',
        '4H 3H 4D 6S 7S vs 8H 3H 4D 6S AS'
      ]

      hand_pair_factory = mock(:hand_pair_factory)
      lines.each do |string|
        pair = string.split(' vs ').map { |hand| hand.split }
        hand_pair_factory.should_receive(:call).with(pair)
      end

      parser = Poker::LineParser.new hand_pair_factory: hand_pair_factory
      parser.lines_to_hand_pairs(lines)
    end
  end
end
