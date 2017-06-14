require "option_parser"

module TwentyFortyEight
  class Cli < OptionParser
    OPTIONS = { "size" => "4" } of String => String

    def self.options
      user_options = OPTIONS.dup

      OptionParser.parse! do |command|
        command.banner = "Usage: 2048 [options]"

        command.on "-s SIZE", "--size=SIZE", "set the size of the board, default 4" do |size|
          user_options["size"] = size
        end

        command.on "-h", "--help", "show this help and exit" do
          puts command
          exit
        end
      end

      user_options
    end
  end
end
