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
        cards_grouped_by_value = hand.cards.group_by { |card| card.to_i }.values
        cards_grouped_by_value.select { |cards_of_same_value|
            cards_of_same_value.count == 2
        }.count == 1
      end

      def >(other_hand)
      end
    end
  end
end
