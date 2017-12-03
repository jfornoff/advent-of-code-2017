defmodule Daythree.PartTwoTest do
  use ExUnit.Case, async: true

  test ".field_values" do
    expected_result = [
      1,
      1,
      2,
      4,
      5,
      10,
      11,
      23,
      25,
      26,
      54,
      57,
      59,
      122,
      133,
      142,
      147,
      304,
      330,
      351,
      362,
      747,
      806
    ]

    actual_result =
      Daythree.PartTwo.field_values()
      |> Enum.take(length(expected_result))

    assert(actual_result == expected_result)
  end
end
