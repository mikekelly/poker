require 'poker/categories'

module Poker
  class Hand
    include Categories

    CATEGORY_CLASSES = [
      HighCard,
      Pair,
      TwoPair,
      Trips,
      Straight,
      Flush,
      FullHouse
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

    def ordered_cards
      cards.sort_by { |card| card.to_i }
    end

    def to_s
      raw_hand_data.join ' '
    end

    def cards_grouped_by_value
      cards.group_by { |card| card.to_i }.values
    end

    def cards_grouped_by_suit
      cards.group_by { |card| card.suit }.values
    end

    def kickers
      HighCard.new Hand.new kicker_codes
    end

    def pair
      cards_grouped_by_value.find { |value_group| value_group.count == 2 }
    end

    def three_of_a_kind
      cards_grouped_by_value.find { |value_group| value_group.count == 3 }
    end

    def three_of_a_kind_rank
      three_of_a_kind.first.to_i
    end

    private

    def kicker_codes
      cards_grouped_by_value.select { |value_group|
        value_group.count == 1
      }.flatten.map(&:card_code)
    end
  end
end
