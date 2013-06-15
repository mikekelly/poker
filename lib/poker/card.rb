module Poker
  class Card
    VALUES = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']
    attr_reader :card_code

    def initialize(card_code)
      @card_code = card_code
    end

    def to_i
      VALUES.find_index(value_code) or raise "Invalid card code: #{card_code}"
    end

    def suit
      card_code[1]
    end

    def >(other_card)
      self.to_i > other_card.to_i
    end

    private

    def value_code
      card_code[0]
    end
  end
end
