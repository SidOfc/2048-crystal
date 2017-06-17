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

  # `SIZE`  An `Int32` representing the size of a `Board`
  SIZE  = Options.get :size,   4

  # `COUNT` An `Int32` representing the amount of `Game` samples to create
  COUNT = Options.get :count, 10

  # `MOVES` A `Tuple(Symbol)` defining the available moves for `Game#move`
  MOVES = {:down, :left, :right, :up}

  # Returns a finished `Game` with a `Board` of `SIZE`.
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
    game = Game.new SIZE

    while MOVES.find { |mv| game.move mv }; end

    game
  end

  # Returns an `Array(Game)` of `COUNT` amount of `#sample`
  #
  #
  # ```
  # TwentyFortyEight.samples.each { |sample| puts sample.score }
  # ```
  #
  # Will output:
  #
  # ```text
  # 849
  # 115
  # 420
  # 1436
  # ... 6 additional scores ...
  # ```
  def samples
    Array(Game).new(COUNT) { sample }
  end

  # `COUNT` times `yield` a `#sample`
  #
  # No `Array(Game)` will be created as opposed to calling `#samples` with `Array#each` for instance.
  # The example used in `#samples` can be recreated like this:
  #
  # ```
  # TwentyFortyEight.each_sample { puts game.score }
  # ```
  #
  # Will output:
  #
  # ```text
  # 890
  # 3249
  # 1239
  # 786
  # ... 6 additional scores ...
  # ```
  def each_sample
    COUNT.times { yield sample }
  end
end

TwentyFortyEight.each_sample { |game| puts game.score }
