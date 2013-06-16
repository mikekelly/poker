require 'delegate'

module Poker
  module Categories
    class FullHouse < SimpleDelegator
      def self.includes?(hand)
        !!(hand.three_of_a_kind && hand.pair)
      end
    end
  end
end
