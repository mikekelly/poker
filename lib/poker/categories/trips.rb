require 'delegate'

module Poker
  module Categories
    class Trips < SimpleDelegator
      def self.includes?(hand)
        !!hand.three_of_a_kind
      end

      def >(other_hand)
        three_of_a_kind_rank > other_hand.three_of_a_kind_rank
      end

      def three_of_a_kind_rank
        three_of_a_kind.first.to_i
      end
    end
  end
end
