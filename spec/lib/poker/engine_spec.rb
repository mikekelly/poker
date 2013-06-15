require 'poker/engine'

describe Poker::Engine do
  describe "#compare" do
    it "sends the lines to the line parser, and for each outputs the pair itself and then the winner" do
      stdout = mock(:stdout)
      line_parser = mock(:line_parser)

      lines = [stub, stub]
      hand_pairs = [stub(winner: stub), stub(winner: stub)]

      line_parser.should_receive(:lines_to_hand_pairs).with(lines).and_return(hand_pairs)
      hand_pairs.each do |hand_pair|
        stdout.should_receive(:puts).with(hand_pair)
        stdout.should_receive(:puts).with(hand_pair.winner)
      end

      engine = Poker::Engine.new stdout: stdout, line_parser: line_parser
      engine.compare(lines)
    end
  end
end
