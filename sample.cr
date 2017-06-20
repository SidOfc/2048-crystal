require "./src/twenty_forty_eight"

count = TwentyFortyEight.options.count
seq   = TwentyFortyEight.options.sequence

if seq && seq.is_a? Array
  mapping = {"l" => :left, "r" => :right, "u" => :up, "d" => :down}
  seq     = seq.to_s.split(',').map { |c| mapping[c] }

  count.times do
    result = TwentyFortyEight.sample { seq.find { |dir| move dir } }.score
    puts result if TwentyFortyEight.options.verbose
  end
else
  count.times do
    result = TwentyFortyEight.sample.score
    puts result if TwentyFortyEight.options.verbose
  end
end
