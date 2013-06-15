module Poker
  class Engine
    attr_reader :stdout, :line_parser

    def initialize(opts)
      @stdout = opts[:stdout] || $stdout
      @line_parser = opts[:line_parser] || LineParser.new
    end

    def compare(lines)
      line_parser.lines_to_hand_pairs(lines).each do |hand_pair|
        stdout.puts hand_pair
        stdout.puts hand_pair.winner
      end
    end
  end
end
