defmodule DaytenTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "trivial" do
      # No change: [1, 2, 3]
      assert Dayten.solve_first_part("0", [1, 2, 3]) == 2
    end

    test "one-swap trivial" do
      # [2,1,3]
      assert Dayten.solve_first_part("2", [1, 2, 3]) == 2
    end

    test "another added swap" do
      # [3,1,2]
      assert Dayten.solve_first_part("2,2", [1, 2, 3]) == 3
    end

    test "example from description" do
      # [3, 4, 2, 1, 0]
      assert Dayten.solve_first_part("3,4,1,5", [0, 1, 2, 3, 4]) == 12
    end
  end
end
