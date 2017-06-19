require "colorize"

require "./2048/version"
require "./2048/options"
require "./2048/game"

# This is the main container that allows you to interact with the underlying
# `Game` class, it provides two simple methods to allow
# for automatic gameplay and controlling gameplay using a block. Sizes of `#sample`
# games are defined by `SIZE` which in turn can be defined on the
# command line, see `Options` or `2048 -h` for more information
module TwentyFortyEight
  extend self

  # `SIZE` An `Int32` representing the size of a `Board`
  SIZE = Options.get(:size, 4).to_i

  # Returns a finished `Game` with a `Board` of `SIZE`
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
  def sample
    sample { down || left || right || up }
  end

  # Returns a finished `Game` with a `Board` of `SIZE`
  #
  # This method plays a game with a specified block,
  # the game is the receiver of methods within that block.
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
  def sample
    game = Game.new SIZE

    until game.over?
      with game yield
    end

    game
  end
end

count = TwentyFortyEight::Options.get(:count, 1).to_i
seq   = TwentyFortyEight::Options.get(:sequence, nil)

if seq && seq.is_a? Array
  mapping = {"l" => :left, "r" => :right, "u" => :up, "d" => :down}
  seq     = seq.to_s.split(',').map { |c| mapping[c] }

  count.times { puts TwentyFortyEight.sample { seq.find { |dir| move dir } }.score }
else
  count.times { puts TwentyFortyEight.sample.score }
end
