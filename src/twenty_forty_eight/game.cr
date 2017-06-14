module TwentyFortyEight
  class Game
    getter :size, :matrix, :options

    def initialize(@size : Int32 = 4)
      @matrix = Array(Array(Int32)).new(size) { Array.new(size) { |i| i } }
    end

    def play
      puts Cli.options["size"]
      self
    end

    def self.play(*args)
      new(*args).play
    end
  end
end
