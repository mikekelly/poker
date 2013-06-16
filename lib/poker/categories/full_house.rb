require 'delegate'

module Poker
  module Categories
    class FullHouse < SimpleDelegator
      def self.includes?(hand)
        !!(hand.three_of_a_kind && hand.pair)
      end

      def >(other_hand)
        three_of_a_kind_rank > other_hand.three_of_a_kind_rank
      end
    end
  end
end
