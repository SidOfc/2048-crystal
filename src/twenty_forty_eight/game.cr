module TwentyFortyEight
  alias Row   = Array(Int32)
  alias Board = Array(Row)

  class Game
    getter :score

    @score   : Int32 = 0
    @changed : Bool  = false
    @over    : Bool  = false

    def initialize(@size = 4)
      @board = Board.new(@size) { Row.new(@size) { 0 } }

      2.times { insert }
    end

    def move(direction)
      unchanged!

      case direction
      when :left  then left
      when :right then right
      when :up    then up
      when :down  then down
      end

      changed? && insert
    end

    def insert
      pos = empty.sample
      @board[pos[:x]][pos[:y]] = Random.rand(1..10) == 1 ? 4 : 2
    end

    def empty
      @size.times.map do |x|
        @size.times.map do |y| {x: x, y: y} if @board[x][y] == 0
        end
      end.flatten.to_a.compact
    end

    def over?
      @over || unchanged? && unmergeable? && (@over = true)
    end

    def changed?
      @changed
    end

    def unchanged?
      !changed?
    end

    private def unmergeable?
      return true if @board.none? { |row| check row }
      return transpose && true if transpose && @board.none? { |row| check row }
    end

    private def changed!
      @changed = true
    end

    private def unchanged!
      @changed = false
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

    private def check(row)
      (1...@size).any? { |idx| row[idx - 1] == row[idx] }
    end

    private def merge(row)
      tmp = row - [0]
      res = Row.new

      while cur = tmp.shift?
        cmp = tmp.shift?

        if cur == cmp
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
      changed! if res != row
      res
    end
  end
end
