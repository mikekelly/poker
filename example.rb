$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'poker'

text_file_path = File.expand_path('../example.txt', __FILE__)
file = File.open text_file_path

engine = Poker::Engine.new
engine.compare(file)
