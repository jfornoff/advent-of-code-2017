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

  describe ".solve_second_part" do
    test "empty string" do
      assert Dayten.solve_second_part("") == "a2582a3a0e66e6e86e3812dcb672a272"
    end

    test "AoC 17" do
      assert Dayten.solve_second_part("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
    end

    test "1,2,3" do
      assert Dayten.solve_second_part("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
    end

    test "1,2,4" do
      assert Dayten.solve_second_part("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
    end
  end
end
