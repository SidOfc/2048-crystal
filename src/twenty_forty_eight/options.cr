require "option_parser"

module TwentyFortyEight
  # Stores an instance op `Options` with parsed command line arguments
  def self.options
    @@options ||= Options.new
  end

  # A simple command line argument wrapper
  #
  # See the defined instance methods for possible options
  # exist yet. To learn how to set these from a command line, run `2048 -h`
  struct Options
    # Returns `Int32` size of the board
    getter :size

    # Returns `Int32` count of games to be played
    getter :count

    # Returns `Bool` true or false for printing output
    getter :verbose

    # Returns `(Array(Char) | Nil)` a sequence like `['d', 'l', 'r', 'u']` to perform moves in preference: down, left, right, up
    getter :sequence

    # If need be, all the default settings can be set in the constructor
    def initialize(@size = 4, @count = 1, @verbose = true, @sequence : Array(Char)? = nil)
      sz, ct, vb, sq = @size, @count, @verbose, @sequence

      OptionParser.parse! do |program|
        program.banner = "Usage: 2048 [options]"

        program.on "-q", "--quiet", "don't print score after each game" do
          vb = false
        end

        program.on "-s SIZE", "--size=SIZE", "set the size of the board" do |size|
          sz = size.to_i
        end

        program.on "-c COUNT", "--count=COUNT", "set the number of games played" do |game_count|
          ct = game_count.to_i
        end

        program.on "-p PREFERENCE", "--preference=PREFERENCE", "preference: dlru => down left right up, (ex: -p dlru) missing keys will be appended to prevent getting stuck" do |text|
          sq = text.chars.concat(['l', 'r', 'u', 'd'] - text.chars)
        end

        program.on "-h", "--help", "show this help and exit" do
          puts program
          exit
        end
      end

      @size, @count, @verbose, @sequence = sz, ct, vb, sq
    end
  end
end

