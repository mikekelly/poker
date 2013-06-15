module Poker
  class LineParser
    attr_reader :hand_pair_factory

    def initialize(opts={})
      @hand_pair_factory = opts[:hand_pair_factory] || HandPair.public_method(:new)
    end

    def lines_to_hand_pairs(lines)
      lines.map do |line|
        hand_pair_factory.call parse_line_to_array line
      end
    end

    private

    def parse_line_to_array(line)
      line.split(' vs ').map { |hand| hand.split }
    end
  end
end
