require "./options"

module TwentyFortyEight
  alias Row   = Array(Int32)
  alias Board = Array(Row)

  class Game
    getter :score

    @score   : Int32 = 0
    @size    : Int32 = Options.get(:size, 4).to_i
    @board   : Board = Board.new(@size) { Array(Int32).new(@size) { 0 } }
    @changed : Bool  = false

    def initialize
      insert 2
    end

    def to_s
      @board.each do |row|
        puts row.map { |value| tile value }.join(" | ")
      end
    end

    def move(direction : (String | Symbol))
      changed false

      case direction.to_s
      when "left"  then left
      when "right" then right
      when "up"    then up
      when "down"  then down
      end

      changed? && insert
    end

    def insert(amount : Int32 = 1)
      amount.times do
        pos = empty.sample
        @board[pos[:x]][pos[:y]] = Random.rand(1..10) == 1 ? 4 : 2
      end
      true
    end

    def empty
      @size.times.map do |x|
        @size.times.map do |y| {x: x, y: y} if @board[x][y] == 0
        end
      end.flatten.to_a.compact
    end

    def end?
      !@changed && !mergeable?
    end

    def changed?
      @changed
    end

    def mergeable?
      %w[left right up down].any? { |dir| dup.move dir }
    end

    def changed(state : Bool)
      @changed = state
    end

    def self.play
      game = new

      puts "Starting game"
      until game.end?
        direction = %w[left right up down].sample
        game.move direction

        puts "#{direction}:#{game.score}:#{game.changed?}:#{game.empty.size}"

        sleep Options.get(:delay, 250).to_i / 1000
      end
      puts "Game ended, score: #{game.score}"
    end

    private def up
      transpose && left && transpose
    end

    private def down
      transpose && right && transpose
    end

    private def left
      @board.map! { |row| merge row }
    end

    private def right
      @board.map! { |row| merge(row.reverse).reverse }
    end

    private def transpose
      @board = @board.transpose
    end

    private def merge(row : Row)
      tmp = row - [0]
      res = Row.new

      while cur = tmp.shift?
        cmp = tmp.shift?

        if cur == cmp
          changed true
          mrg     = cur << 1
          res    << mrg
          @score += mrg
        else
          res << cur
          break unless cmp
          tmp.unshift cmp
        end
      end

      res = res.concat Row.new(row.size - res.size) { 0 }
      changed true if res != row
      res
    end

    private def tile(value : Int32, width = 7)
      str = value.to_s
      div = (width - str.size) / 2.0

      ["".ljust(div.floor.to_i), str, "".rjust(div.ceil.to_i)].join
    end
  end
end
