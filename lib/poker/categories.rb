module Poker
  module Categories
    class HighCard
      def self.includes?(hand)
        true
      end
    end

    class Pair
      def self.includes?(hand)
      end
    end
  end
end
