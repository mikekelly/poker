require 'delegate'

module Poker
  module Categories
    class Flush < SimpleDelegator
      def self.includes?(hand)
        hand.cards_grouped_by_suit.count == 1
      end
    end
  end
end
