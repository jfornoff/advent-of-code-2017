defmodule DaynineTest do
  use ExUnit.Case

  describe ".solve_first_part" do
    test "single group" do
      assert(Daynine.solve_first_part("{}") == 1)
    end

    test "one level nested group" do
      assert(Daynine.solve_first_part("{{}}") == 3)
    end

    test "one level nested group (twice)" do
      assert(Daynine.solve_first_part("{{},{}}") == 5)
    end

    test "two level nested group" do
      assert(Daynine.solve_first_part("{{{}}}") == 6)
    end

    test "many groups" do
      assert(Daynine.solve_first_part("{{{},{},{{}}}}") == 16)
    end

    test "group with garbage" do
      assert(Daynine.solve_first_part("{<a>,<a>,<a>,<a>}") == 1)
    end

    test "nested groups with garbage inside" do
      assert(Daynine.solve_first_part("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9)
    end

    test "nested groups with !!s" do
      assert(Daynine.solve_first_part("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9)
    end

    test "nested garbage with negated garbage terminators" do
      assert(Daynine.solve_first_part("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3)
    end
  end
end
