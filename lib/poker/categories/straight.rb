module Poker
  module Categories
    class Straight
      def self.includes?(hand)
        ordered_card_ranks = hand.cards.map { |card| card.to_i }.sort

        hand.cards_grouped_by_value.count == 5 && # all cards unique and
          ordered_card_ranks.last - ordered_card_ranks.first == 4 # range is 4
      end
    end
  end
end
