module Poker
  class HandPair
    attr_reader :hands_data

    def initialize(hands)
      @hands_data = hands
    end

    def to_s
      hands_data.map { |hand| hand.join ' ' }.join ' vs '
    end
  end
end
