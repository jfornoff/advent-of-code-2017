defmodule DaytwelveTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "example from description" do
      result =
        """
        0 <-> 2
        1 <-> 1
        2 <-> 0, 3, 4
        3 <-> 2, 4
        4 <-> 2, 3, 6
        5 <-> 6
        6 <-> 4, 5
        """
        |> Daytwelve.solve_first_part()

      assert result == 6
    end
  end

  describe ".solve_second_part" do
    test "example from description" do
      result =
        """
        0 <-> 2
        1 <-> 1
        2 <-> 0, 3, 4
        3 <-> 2, 4
        4 <-> 2, 3, 6
        5 <-> 6
        6 <-> 4, 5
        """
        |> Daytwelve.solve_second_part()

      assert result == 2
    end
  end
end
