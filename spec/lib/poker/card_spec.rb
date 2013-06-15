require 'poker/card'

describe Poker::Card do
  describe "#to_i" do
    value_codes_to_values = {
      '2' => 0,
      '9' => 7,
      'T' => 8,
      'J' => 9,
      'Q' => 10,
      'K' => 11,
      'A' => 12
    }

    value_codes_to_values.each do |value_code, value|
      suit_code = 'H'
      card_code = value_code + suit_code

      it "should return #{value} when instantiated with card code #{card_code}" do
        card = Poker::Card.new(card_code)
        card.to_i.should == value
      end
    end
  end

  describe "#suit" do
    card_codes_to_suits = {
      '2H' => 'H',
      'TD' => 'D',
      'AS' => 'S',
      '5C' => 'C'
    }

    card_codes_to_suits.each do |card_code, suit|
      it "should return #{suit} when instantiated with card code #{card_code}" do
        card = Poker::Card.new(card_code)
        card.suit.should == suit
      end
    end
  end
end
