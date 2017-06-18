require "./twenty_forty_eight/version"
require "./twenty_forty_eight/options"
require "./twenty_forty_eight/game"

# This is a ported version of my implementation of [2048 in Ruby](https://rubygems.org/gems/TwentyFortyEight)
# It only implements a small subset of its functionality at the moment, I decided to create a port because
# I wanted to have some fun with a compiled language for a change and Crystal so far has been awesome to write in!
#
# see `Options` to find out more or run `2048 -h` to see a list of options
module TwentyFortyEight
  extend self

  # `SIZE` An `Int32` representing the size of a `Board`
  SIZE = Options.get :size, 4

  # Returns a finished `Game` with a `Board` of `SIZE`
  #
  # The meaning of 'finished' here is simply that the game is `Game#over?`
  # Moves are selected in order of `MOVES` until a move has returned it's value.
  # To give a short example, if `:down` isn't possible, it will try `:left` afterwards.
  # This process is repeated until all available moves return false
  #
  # ```
  # puts TwentyFortyEight.sample.score
  # ```
  #
  # Will output:
  #
  # ```text
  # 1234
  # ```
  def sample
    sample { down || left || right || up }
  end

  # Returns a finished `Game` with a `Board` of `SIZE`
  #
  # This method plays a game with a specified block,
  # the game is the receiver of methods within the block and
  # you are responsible for calling `#move` with one of `MOVES` or calling
  # a directional move e.g. `#down`, `#left`, `#right` or `#up`.
  #
  # **The game ends when the block returns a falsy value!**
  #
  # An example that matches the regular `#sample`:
  #
  # ```
  # puts TwentyFortyEight.sample { down || left || right || up }.score
  # ```
  #
  # Will output:
  #
  # ```
  # 4052
  # ```
  def sample
    game = Game.new SIZE

    while with game yield; end

    game
  end
end

TwentyFortyEight::Options.get(:count, 10).times do
  puts TwentyFortyEight.sample.score
end
