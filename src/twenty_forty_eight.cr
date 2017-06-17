require "./twenty_forty_eight/version"
require "./twenty_forty_eight/options"
require "./twenty_forty_eight/game"

module TwentyFortyEight
  extend self

  SIZE  = Options.get :size
  COUNT = Options.get :count
  MOVES = {:down, :left, :right, :up}

  def sample
    game = Game.new SIZE

    until game.over?
      next if game.move(cur = MOVES.sample)
      MOVES.reject(&.==(cur)).each { |nxt| break if game.move nxt }
    end

    game
  end

  def samples
    COUNT.times { sample }
  end

  def samples
    COUNT.times { yield sample }
  end
end

TwentyFortyEight.samples { |sample| puts sample.score }
