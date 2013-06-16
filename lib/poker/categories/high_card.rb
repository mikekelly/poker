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
  end
end
