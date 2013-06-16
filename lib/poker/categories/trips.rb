require 'delegate'

module Poker
  module Categories
    class Trips < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).three_of_a_kind
      end

      def >(other_hand)
        three_of_a_kind_rank > other_hand.three_of_a_kind_rank
      end

      def three_of_a_kind_rank
        three_of_a_kind.first.to_i
      end

      def three_of_a_kind
        cards_grouped_by_value.find { |value_group| value_group.count == 3 }
      end
    end
  end
end
