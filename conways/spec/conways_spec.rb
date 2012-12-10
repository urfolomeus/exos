require_relative '../lib/conways'

describe "Game of Life rules" do
  context "for a live cell" do
    it "dies with less than 2 live neighbours" do
      Cell.new(:live, :live_neighbours => 1).next_state.should == :dead
    end
    it "lives with 2 live neighbours" do
      Cell.new(:live, :live_neighbours => 2).next_state.should == :live
    end
    it "lives with 3 live neighbours" do
      Cell.new(:live, :live_neighbours => 3).next_state.should == :live
    end
    it "dies with more than 3 live neighbours" do
      Cell.new(:live, :live_neighbours => 4).next_state.should == :dead
    end
  end

  context "for a dead cell" do
    it "lives with 3 live neighbours" do
      Cell.new(:dead, :live_neighbours => 3).next_state.should == :live
    end
    it "stays dead with less than 3 live neighbours" do
      Cell.new(:dead, :live_neighbours => 2).next_state.should == :dead
    end
    it "stays dead with more than 3 live neighbours" do
      Cell.new(:dead, :live_neighbours => 4).next_state.should == :dead
    end
  end
end