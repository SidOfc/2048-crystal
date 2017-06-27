require "./twenty_forty_eight"
require "./twenty_forty_eight/options"

TwentyFortyEight.options.count.times do |i|
  puts TwentyFortyEight.sample(TwentyFortyEight.options.size).score
end
