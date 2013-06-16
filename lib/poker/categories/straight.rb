require 'delegate'

module Poker
  module Categories
    class Straight < SimpleDelegator
      def self.includes?(hand)
        ordered_card_ranks = hand.ordered_cards.map(&:to_i)

        hand.cards_grouped_by_value.count == 5 && # all cards unique and
          ordered_card_ranks.last - ordered_card_ranks.first == 4 # range is 4
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
