defmodule Daysix do
  @input [14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4]
  def solve_part_one(allocation \\ @input) do
    do_solve(allocation, 0, [])
  end

  defp do_solve(allocation, step_counter, allocations_seen) do
    if Enum.member?(allocations_seen, allocation) do
      step_counter
    else
      do_solve(reallocate(allocation), step_counter + 1, [allocation | allocations_seen])
    end
  end

  defp reallocate(allocation) do
    index_to_redistribute =
      allocation
      |> Enum.find_index(fn value ->
           value == Enum.max(allocation)
         end)

    do_reallocate(
      allocation |> List.update_at(index_to_redistribute, fn _ -> 0 end),
      next_index(index_to_redistribute, allocation),
      allocation |> Enum.at(index_to_redistribute)
    )
  end

  def do_reallocate(current_allocation, _, 0), do: current_allocation

  def do_reallocate(current_allocation, index_to_insert_at, left_to_insert) do
    do_reallocate(
      increment_at_index(current_allocation, index_to_insert_at),
      next_index(index_to_insert_at, current_allocation),
      left_to_insert - 1
    )
  end

  defp increment_at_index(allocation, index) do
    List.update_at(allocation, index, &(&1 + 1))
  end

  # Wraps index around if it'd go out of bounds
  defp next_index(index, allocation) do
    rem(index + 1, length(allocation))
  end
end
