require 'delegate'

module Poker
  module Categories
    class FourOfAKind < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).four_of_a_kind
      end

      def four_of_a_kind
        cards_grouped_by_value.find { |value_group| value_group.count == 4 }
      end
    end
  end
end
