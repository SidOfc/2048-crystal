module TwentyFortyEight

  # `Row` is an alias of type `Array(Int32)`, it is used internally during creation and merging of a `Board`
  alias Row   = Array(Int32)

  # `Board` is an alias of type `Array(Row)`, it is the internal container of the entire field
  alias Board = Array(Row)

  # The `Game` class does all the heavy lifting, a new game with a default size of `4` will be initialized,
  # then two pieces will be inserted in random a `#empty` position
  class Game
    # Returns an `Int32` containing the current score
    getter :score

    # Returns the current state of the games' `Board`
    getter :board

    # Returns an `Int32` containing the size of the current `Board`
    getter :size

    # An `Int32` representing the initial `#score`
    @score   : Int32 = 0

    # A `Bool` indicating the initial state of `#changed?` and `#unchanged?`
    @changed : Bool  = false

    # Returns a `Game` of optionally specified size and inserts two values at random `#empty` positions
    def initialize(@size = 4)
      @board = Board.new(size) { Row.new(size) { 0 } }

      2.times { insert }
    end

    # Returns the resulting `Symbol` of executed `direction` if successful (e.g. `#changed? => true`) or nil
    def move(direction)
      case direction
      when :left  then left
      when :right then right
      when :up    then up
      when :down  then down
      end
    end

    # Returns the `Symbol` `:up` if the move `#changed?` the state of the game
    def up
      :up if transposed { left }
    end

    # Returns the `Symbol` `:down` if the move `#changed?` the state the game
    def down
      :down if transposed { right }
    end

    # Returns the `Symbol` `:left` if the move `#changed?` the state the game
    def left
      unchanged!
      :left if board.map! { |row| merge row } && changed? && insert
    end

    # Returns the `Symbol` `:right` if the move `#changed?` the state the game
    def right
      unchanged!
      :right if board.map! { |row| merge(row.reverse).reverse } && changed? && insert
    end

    # Returns the `Int32` value inserted at a random `#empty` position
    def insert
      pos = empty.sample
      board[pos[:x]][pos[:y]] = Random.rand(1..10) == 1 ? 4 : 2
    end

    # Returns an `Array(NamedTuple(x: Int32, y: Int32))` of `:x` and `:y` positions
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
    # Which is the correct result in an initialized `Game` using the default size of `4`
    def empty
      size.times.flat_map do |x|
        size.times.compact_map { |y| {x: x, y: y} if board[x][y] == 0 }
      end.to_a
    end

    # Returns a `Bool` wether the game is `#over?`
    def over?
      unchanged? && unmergeable?
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
      return true if board.none? { |row| check row }
      return true if transposed { board.none? { |row| check row } }
    end

    private def changed!
      @changed = true
    end

    private def unchanged!
      @changed = false
    end

    private def transpose
      @board = @board.transpose
    end

    private def transposed
      transpose
      result = with self yield
      transpose
      result
    end

    private def check(row)
      (1...size).any? { |idx| row[idx - 1] == row[idx] }
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
