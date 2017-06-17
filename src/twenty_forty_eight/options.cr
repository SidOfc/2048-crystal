require "option_parser"

module TwentyFortyEight
  module Options
    extend self

    @@options = { :size => 4, :count => 1 }

    def get(key)
      @@options[key]
    end

    def get(key, default)
      @@options[key]? || default
    end

    OptionParser.parse! do |command|
      command.banner = "Usage: 2048 [options]"

      command.on "-s SIZE", "--size=SIZE", "set the size of the board, default 4" do |size|
        @@options[:size] = size.to_i
      end

      command.on "-c COUNT", "--count=COUNT", "set the number of games played" do |count|
        @@options[:count] = count.to_i
      end

      command.on "-h", "--help", "show this help and exit" do
        puts command
        exit
      end
    end
  end
end
