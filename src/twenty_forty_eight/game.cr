module TwentyFortyEight

  # `Row` is an alias of type `Array(Int32)`, it is used internally during creation and merging of a `Board`
  alias Row   = Array(Int32)

  # `Board` is an alias of type `Array(Row)`, it is the internal container of the entire field
  alias Board = Array(Row)

  # The `Game` class does all the heavy lifting, a new game with a default size of `4` will be initialized,
  # then two pieces will be inserted in random a `#empty` position
  class Game
    getter :score

    # An `Int32` representing the initial `#score`
    @score   : Int32 = 0

    # A `Bool` indicating the initial state of `#changed?` and `#unchanged?`
    @changed : Bool  = false

    # A `Bool` indicating the initial state of `#over?`
    @over    : Bool  = false

    # Returns a `Game` of optionally specified size and inserts two values at random `#empty` positions
    def initialize(@size = 4)
      @board = Board.new(@size) { Row.new(@size) { 0 } }

      2.times { insert }
    end

    # Returns a `Symbol` containing any of `TwentyFortyEight::MOVES` or `Bool` false if the game remains `#unchanged?`
    def move(direction)
      unchanged!

      case direction
      when :left  then left
      when :right then right
      when :up    then up
      when :down  then down
      end

      changed? && insert && direction
    end

    # Returns the `Int32` value inserted at a random `#empty` position
    def insert
      pos = empty.sample
      @board[pos[:x]][pos[:y]] = Random.rand(1..10) == 1 ? 4 : 2
    end

    # Returns an `Array(NamedTuple(x: Int32, y: Int32))`
    #
    # Running the following example:
    #
    # ```
    # puts TwentyFortyEight::Game.new.empty.sample[:x]
    # ```
    #
    # Will output:
    #
    # ```text
    # 2
    # ```
    #
    # Additionally, `#empty` can be used to calculate the amount of empty tiles e.g.
    #
    # ```
    # puts TwentyFortyEight::Game.new.empty.size
    # ```
    #
    # Will output:
    #
    # ```text
    # 14
    # ```
    #
    # Which is the correct result in an initialized `Game` using the default size of 4
    def empty
      @size.times.flat_map do |x|
        @size.times.compact_map { |y| {x: x, y: y} if @board[x][y] == 0 }
      end.to_a
    end

    # Returns a `Bool` wether the game is `#over?`
    def over?
      @over || unchanged? && unmergeable? && (@over = true)
    end

    # Returns a `Bool` wether the game has `changed?` since last move
    def changed?
      @changed
    end

    # Returns a `Bool` - the inverted of `#changed?`
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
