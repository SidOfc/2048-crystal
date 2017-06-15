require "./twenty_forty_eight/version"
require "./twenty_forty_eight/options"
require "./twenty_forty_eight/game"

module TwentyFortyEight
  extend self
end

TwentyFortyEight::Game.play
