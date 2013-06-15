require 'poker/categories'

module Poker
  class Hand
    include Categories

    CATEGORY_CLASSES = [
      HighCard,
      Pair
    ]

    attr_reader :raw_hand_data, :card_factory

    def initialize(hand, opts={})
      @raw_hand_data = hand
      @card_factory = opts[:card_factory] || Card.public_method(:new)
      @category = opts[:category]
    end

    def >(other_hand)
      if self.category == other_hand.category
        self.within_category > other_hand.within_category
      else
        self.category_rank > other_hand.category_rank
      end
    end

    def category_rank
      CATEGORY_CLASSES.find_index(category).to_i
    end

    def within_category
      category.new self
    end

    def category
      @category ||= CATEGORY_CLASSES.reverse.detect { |category_class|
        category_class.includes?(self)
      }
    end

    def cards
      @cards ||= raw_hand_data.map { |hand|
        card_factory.call(hand)
      }
    end

    def to_s
      raw_hand_data.join ' '
    end
  end
end
