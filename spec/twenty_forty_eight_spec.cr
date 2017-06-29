require "./spec_helper"

describe TwentyFortyEight do
  # TODO: Write tests
  context "with specified size" do
    it "creates a properly sized board" do
      TwentyFortyEight::Game.new(6).board.size.should eq 6
      TwentyFortyEight.sample(6).board.size.should eq 6
    end

    it "can play a game" do
      TwentyFortyEight.sample(6).over?.should eq true
    end
  end

  context "with specified board" do
    it "initializes with proper size" do
      game = TwentyFortyEight::Game.new [[0, 0, 0],
                                         [2, 0, 0],
                                         [2, 0, 0]]

      game.size.should eq 3
    end

    it "can play a game" do
      dirs = {'l', 'u', 'd', 'r'}
      game = TwentyFortyEight.sample [[0, 0, 0],
                                      [2, 0, 0],
                                      [2, 0, 0]]

      game.over?.should eq true
    end
  end

  context "merges properly" do
    it "up" do
      game = TwentyFortyEight::Game.new [[2, 0, 0, 0],
                                         [2, 0, 0, 0],
                                         [2, 0, 0, 0],
                                         [2, 0, 0, 0]]

      game.move(:up).should eq :up
      game.board[0][0].should eq 4
      game.board[1][0].should eq 4
    end

    it "down" do
      game = TwentyFortyEight::Game.new [[2, 0, 0, 0],
                                         [2, 0, 0, 0],
                                         [2, 0, 0, 0],
                                         [2, 0, 0, 0]]

      game.move(:down).should eq :down
      game.board[2][0].should eq 4
      game.board[3][0].should eq 4
    end

    it "left" do
      game = TwentyFortyEight::Game.new [[2, 2, 2, 2],
                                         [0, 0, 0, 0],
                                         [0, 0, 0, 0],
                                         [0, 0, 0, 0]]

      game.move(:left).should eq :left
      game.board[0][0].should eq 4
      game.board[0][1].should eq 4
    end

    it "right" do
      game = TwentyFortyEight::Game.new [[2, 2, 2, 2],
                                         [0, 0, 0, 0],
                                         [0, 0, 0, 0],
                                         [0, 0, 0, 0]]

      game.move(:right).should eq :right
      game.board[0][3].should eq 4
      game.board[0][2].should eq 4
    end
  end
end
