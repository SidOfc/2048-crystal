require "./src/twenty_forty_eight"

count = TwentyFortyEight.options.count
seq   = TwentyFortyEight.options.sequence

if seq && seq.is_a? Array
  mapping = {"l" => :left, "r" => :right, "u" => :up, "d" => :down}
  seq     = seq.to_s.split(',').map { |c| mapping[c] }

  count.times { puts TwentyFortyEight.sample { seq.find { |dir| move dir } }.score }
else
  count.times { puts TwentyFortyEight.sample.score }
end
