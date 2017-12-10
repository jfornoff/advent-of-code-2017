defmodule Dayten do
  @lengths_input "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70"
  @list 0..255 |> Enum.into([])

  defmodule Iteration do
    defstruct [:current_list, :current_index, :skip_length]

    def initial(list) do
      %__MODULE__{
        current_list: list,
        current_index: 0,
        skip_length: 0
      }
    end
  end

  def solve_first_part(lengths \\ @lengths_input, list \\ @list) do
    result =
      lengths
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(Iteration.initial(list), fn swap_length, iteration ->
           new_list =
             iteration.current_list
             |> cycle_by(iteration.current_index)
             |> Enum.reverse_slice(0, swap_length)
             |> cycle_by(length(iteration.current_list) - iteration.current_index)

           %Iteration{
             current_list: new_list,
             current_index: next_focused_index(iteration, swap_length),
             skip_length: iteration.skip_length + 1
           }
         end)

    [first_item, second_item | _] = result.current_list
    first_item * second_item
  end

  defp next_focused_index(iteration, swap_length) do
    rem(
      iteration.current_index + swap_length + iteration.skip_length,
      length(iteration.current_list)
    )
  end

  defp cycle_by(list, steps) do
    list
    |> Enum.split(steps)
    |> swap_and_concat
  end

  defp swap_and_concat({first, last}) do
    last ++ first
  end
end
