defmodule DayfiveTest do
  use ExUnit.Case
  doctest Dayfive

  describe ".solve_first" do
    test "terminates after one step on [1]" do
      assert(Dayfive.solve_first([1]) == 1)
    end

    test "terminates after two steps on [0]" do
      assert(Dayfive.solve_first([0]) == 2)
    end

    test "example from description" do
      assert(Dayfive.solve_first([0, 3, 0, 1, -3]) == 5)
    end
  end
end
