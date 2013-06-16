module Poker
  class HandPair
    attr_reader :hands_data, :hand_factory

    def initialize(hands, opts={})
      @hands_data = hands
      @hand_factory = opts[:hand_factory] || Hand.public_method(:new)
    end

    def to_s
      hands_data.map { |hand| hand.join ' ' }.join ' vs '
    end

    def winner
      if first_hand > second_hand
        first_hand
      elsif second_hand > first_hand
        second_hand
      else
        NullHand.new
      end
    end

    private

    def hands
      @hands ||= hands_data.map { |hand_data| hand_factory.call hand_data }
    end

    def first_hand
      hands.first
    end

    def second_hand
      hands[1]
    end
  end

  class NullHand
    def to_s
      "DRAW"
    end
  end
end
