require "option_parser"
require "./twenty_forty_eight/*"

module TwentyFortyEight
  extend self
end

game = TwentyFortyEight::Game.play

