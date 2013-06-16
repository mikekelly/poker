require 'delegate'

module Poker
  module Categories
    class Pair < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).the_pair
      end

      def >(other_hand)
        pair_rank > other_hand.pair_rank || kickers > other_hand.kickers
      end

      def pair_rank
        the_pair.first.to_i
      end

      def the_pair
        cards_grouped_by_value.find { |value_group| value_group.count == 2 }
      end
    end
  end
end
