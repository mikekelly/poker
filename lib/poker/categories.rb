require 'delegate'

module Poker
  module Categories
    class HighCard < SimpleDelegator
      def self.includes?(hand)
        true
      end

      def >(other_hand)
        differing_pair = ordered_cards.zip(other_hand.ordered_cards).find { |pair|
          pair[0] != pair[1]
        }
        differing_pair[0] > differing_pair[1]
      end

      def ordered_cards
        cards.sort_by { |card| card.to_i }.reverse
      end
    end

    class Pair < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).the_pair
      end

      def >(other_hand)
        pair_rank > other_hand.pair_rank
      end

      def pair_rank
        the_pair.first.to_i
      end

      def the_pair
        cards_grouped_by_value.find { |value_group| value_group.count == 2 }
      end

      private

      def cards_grouped_by_value
        cards.group_by { |card| card.to_i }.values
      end
    end
  end
end
