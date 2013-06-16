require 'delegate'

module Poker
  module Categories
    class HighCard < SimpleDelegator
      def self.includes?(hand)
        true
      end

      def >(other_hand)
        differing_pair = ordered_cards.zip(other_hand.ordered_cards).find { |pair|
          pair[0].to_i != pair[1].to_i
        }
        differing_pair && differing_pair[0] > differing_pair[1]
      end

      def ordered_cards
        cards.sort_by { |card| card.to_i }.reverse
      end
    end

    class Pair < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).the_pair
      end

      def >(other_hand)
        pair_rank > other_hand.pair_rank || kickers > other_hand.kickers
      end

      def pair_rank
        the_pair.first.to_i
      end

      def the_pair
        cards_grouped_by_value.find { |value_group| value_group.count == 2 }
      end
    end

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

    class Trips < SimpleDelegator
      def self.includes?(hand)
        !!new(hand).three_of_a_kind
      end

      def three_of_a_kind
        cards_grouped_by_value.find { |value_group| value_group.count == 3 }
      end
    end
  end
end
