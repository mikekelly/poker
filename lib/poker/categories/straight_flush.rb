require 'delegate'

module Poker
  module Categories
    class StraightFlush < SimpleDelegator
      def self.includes?(hand)
        Straight.includes?(hand) && Flush.includes?(hand)
      end
    end
  end
end
