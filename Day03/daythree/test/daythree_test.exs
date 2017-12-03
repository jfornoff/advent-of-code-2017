defmodule Daythree.PartOneTest do
  use ExUnit.Case

  describe ".solve" do
    # Bottom right corners
    test "works for 1" do
      assert(Daythree.PartOne.solve(1) == 0)
    end

    test "works for 9" do
      assert(Daythree.PartOne.solve(9) == 2)
    end

    test "works for 25" do
      assert(Daythree.PartOne.solve(25) == 4)
    end

    # Top right corners
    test "works for 3" do
      assert(Daythree.PartOne.solve(3) == 2)
    end

    test "works for 13" do
      assert(Daythree.PartOne.solve(13) == 4)
    end

    test "works for 31" do
      assert(Daythree.PartOne.solve(31) == 6)
    end

    # Bottom left corners
    test "works for 7" do
      assert(Daythree.PartOne.solve(7) == 2)
    end

    test "works for 21" do
      assert(Daythree.PartOne.solve(21) == 4)
    end

    test "works for 43" do
      assert(Daythree.PartOne.solve(43) == 6)
    end

    # Non-corner fields
    test "works for 12" do
      assert(Daythree.PartOne.solve(12) == 3)
    end

    test "works for 11" do
      assert(Daythree.PartOne.solve(11) == 2)
    end

    test "works for 10" do
      assert(Daythree.PartOne.solve(10) == 3)
    end
  end
end
