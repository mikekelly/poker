require 'delegate'

module Poker
  module Categories
    class StraightFlush < SimpleDelegator
      def self.includes?(hand)
        Straight.includes?(hand) && Flush.includes?(hand)
      end

      def >(other_hand)
        top_card_rank > other_hand.top_card_rank
      end
    end
  end
end
