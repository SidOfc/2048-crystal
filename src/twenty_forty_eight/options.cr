require "option_parser"

module TwentyFortyEight

  # A simple command line argument wrapper
  #
  # To view the available options in a terminal, simply run `2048 -h`
  module Options
    extend self

    # A `Hash(Symbol, Int32)` representing supplied options from the command line
    @@options = {} of Symbol => Int32

    # Returns the value of the `key` if found, make sure it exists!
    def get(key)
      @@options[key]
    end

    # Returns the value of the key if it exists or the supplied default value
    def get(key, default)
      @@options[key]? || default
    end

    # Simply parse the options available to the program using `OptionParser`
    #
    # This is done automatically when the module is included, one can directly use `#get` :)
    OptionParser.parse! do |program|
      program.banner = "Usage: 2048 [options]"

      program.on "-s SIZE", "--size=SIZE", "set the size of the board" do |size|
        @@options[:size] = size.to_i
      end

      program.on "-c COUNT", "--count=COUNT", "set the number of games played" do |count|
        @@options[:count] = count.to_i
      end

      program.on "-h", "--help", "show this help and exit" do
        puts program
        exit
      end
    end
  end
end
