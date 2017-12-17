defmodule DayelevenTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "trivial example" do
      assert Dayeleven.solve_first_part("") == 0
    end

    test "onestep example" do
      assert Dayeleven.solve_first_part("ne") == 1
    end

    test "twostep example" do
      assert Dayeleven.solve_first_part("ne,ne") == 2
    end

    test "first example" do
      assert Dayeleven.solve_first_part("ne,ne,ne") == 3
    end

    test "second example" do
      assert Dayeleven.solve_first_part("ne,ne,sw,sw") == 0
    end

    test "third example" do
      assert Dayeleven.solve_first_part("ne,ne,s,s") == 2
    end
  end

  describe ".solve_second_part" do
    test "somewhat trivial example" do
      assert Dayeleven.solve_second_part("ne,sw") == 1
    end
  end
end
