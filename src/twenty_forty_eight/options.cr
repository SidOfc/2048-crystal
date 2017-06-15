require "option_parser"

module TwentyFortyEight
  module Options
    extend self

    DEFAULTS = { "size" => "4" }

    @@options = {} of String => String

    def get(key : (String | Symbol))
      parse! unless parsed?
      @@options[key.to_s]? || DEFAULTS[key.to_s]?
    end

    def get(key : (String | Symbol), default)
      get(key) || default
    end

    def parsed?
      !@@options
    end

    def parse!
      @@options = DEFAULTS.dup

      OptionParser.parse! do |command|
        command.banner = "Usage: 2048 [options]"

        command.on "-s SIZE", "--size=SIZE", "set the size of the board, default 4" do |size|
          @@options["size"] = size
        end

        command.on "-h", "--help", "show this help and exit" do
          puts command
          exit
        end
      end

      @@options
    end
  end
end
