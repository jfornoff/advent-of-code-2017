defmodule DaysevenTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "three nodes" do
      result =
        """
        foo (10)
        bar (20) -> foo, baz
        baz (5)
        """
        |> Dayseven.solve_first_part()

      assert(result == "bar")
    end

    test "example from description" do
      result =
        """
        pbga (66)
        xhth (57)
        ebii (61)
        havc (66)
        ktlj (57)
        fwft (72) -> ktlj, cntj, xhth
        qoyq (66)
        padx (45) -> pbga, havc, qoyq
        tknk (41) -> ugml, padx, fwft
        jptl (61)
        ugml (68) -> gyxo, ebii, jptl
        gyxo (61)
        cntj (57)
        """
        |> Dayseven.solve_first_part()

      assert(result == "tknk")
    end
  end

  describe ".solve_second_part" do
    test "four nodes" do
      result =
        """
        foo (10)
        bar (20) -> foo, baz, qux
        baz (5)
        qux (5)
        """
        |> Dayseven.solve_second_part()

      assert(result == 5)
    end

    test "example from description" do
      result =
        """
        pbga (66)
        xhth (57)
        ebii (61)
        havc (66)
        ktlj (57)
        fwft (72) -> ktlj, cntj, xhth
        qoyq (66)
        padx (45) -> pbga, havc, qoyq
        tknk (41) -> ugml, padx, fwft
        jptl (61)
        ugml (68) -> gyxo, ebii, jptl
        gyxo (61)
        cntj (57)
        """
        |> Dayseven.solve_second_part()

      assert(result == 60)
    end
  end
end
