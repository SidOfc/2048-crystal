require "./twenty_forty_eight/version"
require "./twenty_forty_eight/game"

# This is the main container that allows you to interact with the underlying
# `Game` struct, it provides two simple methods to allow
# for automatic gameplay and controlling gameplay using a block. Sizes of `#sample`
# games are defined by `SIZE` which in turn can be defined on the
# command line, see `Options` or `2048 -h` for more information
module TwentyFortyEight
  extend self

  # Returns a finished `Game` with a `Board` of specified size `Int32` or input `Array(Array(Int32))`
  #
  # If no arguments are given, a `Board` will be initialized with a default `size` of `4` and 2 values
  # will be inserted a random `#empty` positions on the board. If an input board is specified by supplying
  # a `Array(Array(Int32))` then no values will be inserted prior to playing the game.
  #
  # **NOTE** This means that if a board containing only `0` as values for all fields is passed, the game will never end.
  # This happens because the `#over?` method short circuits when the board isn't full and because of the fact that
  # for a value to be inserted, the board has to have `change?` which it will not have when only moving empty values.
  #
  # Finished simply means `Game#over?`, the game is played automatically
  # by trying each move in order: `Game#down`, `Game#left`, `Game#right` and finally `Game#up`.
  # This process is repeated until no more moves are possible.
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
  def sample(*args)
    sample(*args) { down || left || right || up }
  end

  # Same as `#sample(*args)` but plays the game with provided block, the game is the receiver of methods within the supplied block.
  #
  # you are responsible for calling `Game#move` with one of `:left`, `:right`, `:up` and `:down` or
  # a directional move e.g. `Game#down`, `Game#left`, `Game#right` or `Game#up`.
  #
  # A game ends automatically once `Game#over?` is true.
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
  #
  # A call to any of the available moves in a game will return it's direction as a `Symbol` if successful
  # This means you can find out per move, which direction was moved using:
  #
  # ```
  # TwentyFortyEight.sample { moved = down || left || right || up; puts moved }
  # ```
  #
  # Will output
  #
  # ```text
  # left
  # right
  # down
  # down
  # ... snipped ...
  # up
  # ```
  #
  # also, getters such as `Game#size` and `Game#board` are callable from within the block.
  # What they represent is up to you, depending on wether you call these _before_ or _after_
  # you've executed a successful move.
  def sample(*args)
    game = Game.new *args
    until game.over?; with game yield; end
    game
  end
end
