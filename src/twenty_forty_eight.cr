require "./twenty_forty_eight/version"
require "./twenty_forty_eight/options"
require "./twenty_forty_eight/game"

# This is the main container that allows you to interact with the underlying
# `Game` class, it provides two simple methods to allow
# for automatic gameplay and controlling gameplay using a block. Sizes of `#sample`
# games are defined by `SIZE` which in turn can be defined on the
# command line, see `Options` or `2048 -h` for more information
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
  # you are responsible for calling `#move` with one of `:left`, `:right`, `:up` and `:down` or
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
  # ```text
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
