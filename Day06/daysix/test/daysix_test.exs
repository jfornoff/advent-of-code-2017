defmodule DaysixTest do
  use ExUnit.Case
  doctest Daysix

  describe ".solve_part_one" do
    test "does the trivial case correctly" do
      assert Daysix.solve_part_one([0]) == 1
    end

    test "does the next trivial case correctly" do
      assert Daysix.solve_part_one([1]) == 1
    end

    test "does [0, 1] correctly" do
      assert Daysix.solve_part_one([0, 1]) == 2
    end

    test "example from description" do
      assert Daysix.solve_part_one([
               0,
               2,
               7,
               0
             ]) == 5
    end
  end
end
