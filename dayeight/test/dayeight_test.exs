defmodule DayeightTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "non-matching operation" do
      result =
        """
        a dec 999 if b > 0
        """
        |> Dayeight.solve_first_part()

      assert(result == 0)
    end

    test "matching operation" do
      result =
        """
        a inc 1 if b >= 0
        """
        |> Dayeight.solve_first_part()

      assert(result == 1)
    end

    test "example from description" do
      result =
        """
        b inc 5 if a > 1
        a inc 1 if b < 5
        c dec -10 if a >= 1
        c inc -20 if c == 10
        """
        |> Dayeight.solve_first_part()

      assert(result == 1)
    end
  end
end
