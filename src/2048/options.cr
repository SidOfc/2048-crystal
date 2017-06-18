require "option_parser"

module TwentyFortyEight

  # A simple command line argument wrapper
  #
  # The only usable keys for `#get` at the moment are `:size` and `:count`. No other options
  # exist yet. To learn how to set these from a command line, run `2048 -h`
  module Options
    extend self

    # A `Hash(Symbol, Int32)` representing supplied options from the command line
    @@options = {} of Symbol => Int32 | String

    # Returns the value of the `key` if found, make sure it exists!
    #
    # Given the following command:
    #
    # ```text
    # $ 2048 -s 6 -c 10
    # ```
    #
    # With the following code:
    #
    # ```
    # puts TwentyFortyEight::Options.get :size
    # puts TwentyFortyEight::Options.get :count
    # ```
    #
    # Will output respectively:
    #
    # ```text
    # 6
    # 10
    # ```
    def get(key)
      @@options[key]
    end

    # Returns the value of the key if it exists or the supplied default value
    #
    # Given the following command:
    #
    # ```text
    # $ 2048 -c 10
    # ```
    #
    # With the following code:
    #
    # ```
    # puts TwentyFortyEight::Options.get :size, 4
    # ```
    #
    # Will output respectively:
    #
    # ```text
    # 4
    # 10
    # ```
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

      program.on "-a SEQUENCE", "--auto=SEQUENCE", "sequence like: dlru -> down left right up, missing keys will be appended to prevent getting stuck" do |text|
        @@options[:sequence] = text.chars.concat(['l', 'r', 'u', 'd'] - text.chars).join ','
      end

      program.on "-h", "--help", "show this help and exit" do
        puts program
        exit
      end
    end
  end
end
