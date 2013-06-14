describe "Poker library" do
  def compare(a,b)
    "#{a} vs #{b}"
  end

  it "takes a set of hand comparisons, outputs each to the console followed by the winning hand or DRAW" do
    seven_high = '2H 3H 4D 6S 7S'
    ace_high = '2H 3H 4D 6S AS'
    other_ace_high = '2D 3D 5D 9S AD'
    pair_of_tens = '10D 10S 2H 3H 4D'
    straight_flush = '2H 3H 4H 5H 6H'
    draw = 'DRAW'

    comparisons_to_outcomes = {
      compare(seven_high, ace_high) => ace_high,
      compare(pair_of_tens, straight_flush) => straight_flush,
      compare(ace_high, other_ace_high) => draw
    }

    stdout_mock = mock(:stdout)

    comparisons_to_outcomes.each do |comparison, outcome|
      stdout_mock.should_receive(:puts).with(comparison)
      stdout_mock.should_receive(:puts).with(outcome)
    end
  end
end
