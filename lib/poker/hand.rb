require 'poker/categories'

module Poker
  class Hand
    include Categories

    CATEGORY_CLASSES = [
      HighCard,
      Pair
    ]

    attr_reader :raw_hand_data

    def initialize(hand, opts={})
      @raw_hand_data = hand
      @category = opts[:category]
    end

    def >(other_hand)
      self.category_rank > other_hand.category_rank
    end

    def category_rank
      CATEGORY_CLASSES.find_index(category).to_i
    end

    private

    def category
      @category ||= CATEGORY_CLASSES.detect { |category_class|
        category_class.includes?(self)
      }
    end
  end
end
