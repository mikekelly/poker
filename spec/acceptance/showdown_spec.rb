require 'poker'

describe "Poker library" do
  def compare(a,b)
    "#{a} vs #{b}"
  end

  it "takes a set of hand comparisons, outputs each to the console followed by the winning hand or DRAW" do
    seven_high = '2H 3H 4D 6S 7S'
    ace_high = '2H 3H 4D 6S AS'
    other_ace_high = '2D 3D 5D 9S AD'

    pair_of_tens = 'TD TS 2H 4H AD'
    equal_pair_of_tens = 'TH TC 2D 4S AH'
    losing_pair_of_tens = 'TH TC 2D 3S AH'
    pair_of_jacks = 'JH JC 2D 3S 4H'

    two_pair = '4H 4D 8H 8D 6S'
    better_top_pair = '4S 4C 9H 9D 6D'
    better_bottom_pair = '5H 5D 8S 8C 6D'
    two_pair_better_kicker = '4S 4C 8S 8C 7S'

    trips = '5S 5D 5H 7S 8D'
    better_trips = '6S 6D 6H 7S 8D'

    straight = '2D 3H 4C 5S 6D'
    better_straight = '3D 4S 5H 6C 7D'

    flush = '3H 4H 5H TH JH'
    better_flush = '3H 4H 5H 2H AH'

    straight_flush = '2H 3H 4H 5H 6H'
    draw = 'DRAW'

    comparisons_to_outcomes = {
      compare(seven_high, ace_high) => ace_high,
      compare(other_ace_high, pair_of_tens) => pair_of_tens,
      compare(pair_of_jacks, pair_of_tens) => pair_of_jacks,
      compare(equal_pair_of_tens, pair_of_tens) => draw,
      compare(losing_pair_of_tens, pair_of_tens) => pair_of_tens,
      compare(two_pair, pair_of_tens) => two_pair,
      compare(better_top_pair, two_pair) => better_top_pair,
      compare(better_bottom_pair, two_pair) => better_bottom_pair,
      compare(two_pair_better_kicker, two_pair) => two_pair_better_kicker,
      compare(trips, two_pair) => trips,
      compare(better_trips, trips) => better_trips,
      compare(straight, trips) => straight,
      compare(straight, better_straight) => better_straight,
      compare(straight, flush) => flush,
      compare(better_flush, flush) => better_flush,
    }

    stdout_mock = mock(:stdout)

    comparisons_to_outcomes.each do |comparison, outcome|
      stdout_mock.should_receive(:puts).with(comparison)
      stdout_mock.should_receive(:puts).with(outcome)
    end

    lines = comparisons_to_outcomes.keys

    Poker::Engine.new(stdout: stdout_mock).compare(lines)
  end
end
