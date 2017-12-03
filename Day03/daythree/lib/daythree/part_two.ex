defmodule Daythree.PartTwo do
  defmodule BoardField do
    defstruct [:x, :y, :value]
  end

  defmodule BoardIteration do
    defstruct [:fields, :walking_direction]

    def initial() do
      %__MODULE__{
        fields: [%BoardField{x: 0, y: 0, value: 1}],
        walking_direction: :right
      }
    end
  end

  def solve() do
    field_values()
    |> Stream.drop_while(fn value ->
         value < 368_078
       end)
    |> Enum.take(1)
  end

  def field_values() do
    Stream.resource(
      # Initializer: Center, walking to the right
      fn -> BoardIteration.initial() end,
      # Step: Yield current field value, add new field by walking one step
      fn %BoardIteration{} = current_board_iteration ->
        {
          [hd(current_board_iteration.fields).value],
          next_board(current_board_iteration)
        }
      end,
      # Cleanup after stream end: No cleanup required since we can circle infinitely
      fn _ -> nil end
    )
  end

  defp turn_left(:right), do: :up
  defp turn_left(:up), do: :left
  defp turn_left(:left), do: :down
  defp turn_left(:down), do: :right

  defp next_board(%BoardIteration{fields: fields_so_far, walking_direction: walking_direction}) do
    next_field =
      walk_from(hd(fields_so_far), walking_direction)
      |> assign_value(fields_so_far)

    %BoardIteration{
      fields: [next_field | fields_so_far],
      walking_direction: next_walking_direction(next_field, walking_direction)
    }
  end

  defp assign_value(%BoardField{} = new_field, fields_so_far) do
    value_for_new_field =
      fields_so_far
      |> Enum.filter(fn %BoardField{} = field -> adjacent_field?(new_field, field) end)
      |> Enum.map(fn field -> field.value end)
      |> Enum.sum()

    %BoardField{new_field | value: value_for_new_field}
  end

  defp adjacent_field?(new_field, field) do
    abs(new_field.x - field.x) <= 1 && abs(new_field.y - field.y) <= 1
  end

  defp next_walking_direction(%BoardField{} = field, current_direction) do
    if should_turn_here?(field) do
      turn_left(current_direction)
    else
      current_direction
    end
  end

  defp should_turn_here?(%BoardField{x: x, y: y}) do
    cond do
      # Bottom right quadrant, we're walking one step further to start a new circle
      x > 0 && y <= 0 && x - abs(y) == 1 ->
        true

      # Top right corner
      x > 0 && y > 0 && x == y ->
        true

      # Left side corners
      x < 0 && abs(x) == abs(y) ->
        true

      true ->
        false
    end
  end

  defp walk_from(%BoardField{} = current_position, :up),
    do: %BoardField{current_position | y: current_position.y + 1}

  defp walk_from(%BoardField{} = current_position, :down),
    do: %BoardField{current_position | y: current_position.y - 1}

  defp walk_from(%BoardField{} = current_position, :left),
    do: %BoardField{current_position | x: current_position.x - 1}

  defp walk_from(%BoardField{} = current_position, :right),
    do: %BoardField{current_position | x: current_position.x + 1}
end
