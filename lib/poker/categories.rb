require 'delegate'

module Poker
  module Categories
    class HighCard < SimpleDelegator
      def self.includes?(hand)
        true
      end

      def >(other_hand)
        differing_pair = ordered_cards.zip(other_hand.ordered_cards).find { |pair|
          pair[0].to_i != pair[1].to_i
        }
        differing_pair && differing_pair[0] > differing_pair[1]
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
        pair_rank > other_hand.pair_rank ||
          HighCard.new(self.without_pair) > HighCard.new(other_hand.without_pair)
      end

      def without_pair
        Hand.new(non_pair_card_codes)
      end

      def pair_rank
        the_pair.first.to_i
      end

      def the_pair
        cards_grouped_by_value.find { |value_group| value_group.count == 2 }
      end

      private

      def non_pair_card_codes
        cards_grouped_by_value.reject { |value_group|
          value_group.count == 2
        }.flatten.map(&:card_code)
      end
    end

    class TwoPair < SimpleDelegator
      def self.includes?(hand)
        new(hand).pairs.count == 2
      end

      def >(other_hand)
      end

      def pairs
        cards_grouped_by_value.select { |value_group| value_group.count == 2 }
      end
    end
  end
end
