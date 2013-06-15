require 'delegate'

module Poker
  module Categories
    class HighCard < SimpleDelegator
      def self.includes?(hand)
        true
      end

      def >(other_hand)
      end
    end

    class Pair < SimpleDelegator
      def self.includes?(hand)
      end

      def >(other_hand)
      end
    end
  end
end
