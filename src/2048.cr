require "./twenty_forty_eight"
require "./twenty_forty_eight/options"

count   = TwentyFortyEight.options.count
size    = TwentyFortyEight.options.size
seq     = TwentyFortyEight.options.sequence
verbose = TwentyFortyEight.options.verbose

if seq
  count.times do
    game = TwentyFortyEight.sample { seq.find { |dir| move dir } }
    puts game.score if verbose
  end
else
  count.times do
    game = TwentyFortyEight.sample
    puts game.score if verbose
  end
end
