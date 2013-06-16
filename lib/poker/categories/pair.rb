require 'delegate'

module Poker
  module Categories
    class Pair < SimpleDelegator
      def self.includes?(hand)
        !!hand.pair
      end

      def >(other_hand)
        pair_rank > other_hand.pair_rank || kickers > other_hand.kickers
      end

      def pair_rank
        pair.first.to_i
      end
    end
  end
end
