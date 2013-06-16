require 'delegate'

module Poker
  module Categories
    class TwoPair < SimpleDelegator
      def self.includes?(hand)
        new(hand).pairs.count == 2
      end

      def >(other_hand)
        if top_pair_rank == other_hand.top_pair_rank
          if bottom_pair_rank == other_hand.bottom_pair_rank
            kickers > other_hand.kickers
          else
            bottom_pair_rank > other_hand.bottom_pair_rank
          end
        else
          top_pair_rank > other_hand.top_pair_rank
        end
      end

      def pairs
        cards_grouped_by_value.select { |value_group| value_group.count == 2 }
      end

      def bottom_pair_rank
        bottom_pair.first.to_i
      end

      def top_pair_rank
        top_pair.first.to_i
      end

      private

      def sorted_pairs
        pairs.sort_by { |pair| pair.first.to_i }
      end

      def top_pair
        sorted_pairs.last
      end

      def bottom_pair
        sorted_pairs.first
      end
    end
  end
end
