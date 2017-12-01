defmodule DayOne do
  def solve_first_part(input) do
    digits = String.codepoints(input)
    do_solve(digits, 1)
  end

  def solve_second_part(input) do
    digits = String.codepoints(input)
    do_solve(digits, length(digits) / 2)
  end

  defp do_solve(digits, comparison_offset) when comparison_offset > 0 do
    digits
    |> Enum.zip(cycle(digits, comparison_offset))
    |> Enum.filter(fn {first_digit, second_digit} -> first_digit == second_digit end)
    |> Enum.map(fn {digit, _} -> String.to_integer(digit) end)
    |> Enum.sum()
  end

  defp cycle(digits, steps) do
    digits
    |> Stream.cycle()
    |> Stream.drop(steps)
    |> Enum.take(length(digits))
  end
end
