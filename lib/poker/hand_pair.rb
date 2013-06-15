module Poker
  class HandPair
    attr_reader :hands_data

    def initialize(hands, opts={})
      @hands_data = hands
    end
  end
end
