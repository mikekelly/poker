require 'delegate'

module Poker
  module Categories
    class Flush < SimpleDelegator
      def self.includes?(hand)
        hand.cards_grouped_by_suit.count == 1
      end

      def >(other_hand)
        top_card_rank > other_hand.top_card_rank
      end

      def top_card_rank
        top_card.to_i
      end

      private

      def top_card
        ordered_cards.last
      end
    end
  end
end
