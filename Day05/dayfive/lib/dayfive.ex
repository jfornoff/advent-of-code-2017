defmodule Dayfive do
  defmodule JumpIteration do
    defstruct [:jumplist, :current_position, :steps_taken, :position_update_fn]

    def initial(list, position_update_fn) do
      %JumpIteration{
        jumplist: list,
        current_position: 0,
        steps_taken: 0,
        position_update_fn: position_update_fn
      }
    end

    def next_iteration(%JumpIteration{} = iteration) do
      updated_jumplist =
        iteration.jumplist
        |> List.update_at(iteration.current_position, iteration.position_update_fn)

      updated_position =
        iteration.current_position + Enum.at(iteration.jumplist, iteration.current_position)

      %JumpIteration{
        iteration
        | jumplist: updated_jumplist,
          current_position: updated_position,
          steps_taken: iteration.steps_taken + 1
      }
    end
  end

  def solve_first_from_input() do
    solve_from_input(&solve_first/1)
  end

  def solve_first(list) do
    list
    |> JumpIteration.initial(&(&1 + 1))
    |> do_solve
  end

  def solve_second_from_input() do
    solve_from_input(&solve_second/1)
  end

  def solve_second(list) do
    list
    |> JumpIteration.initial(fn position_value ->
         if position_value >= 3 do
           position_value - 1
         else
           position_value + 1
         end
       end)
    |> do_solve
  end

  defp do_solve(%JumpIteration{current_position: current_position} = iteration)
       when current_position < 0,
       do: iteration.steps_taken

  defp do_solve(%JumpIteration{
         current_position: current_position,
         jumplist: jumplist,
         steps_taken: steps_taken
       })
       when current_position >= length(jumplist),
       do: steps_taken

  defp do_solve(%JumpIteration{} = iteration) do
    iteration
    |> JumpIteration.next_iteration()
    |> do_solve
  end

  defp solve_from_input(solve_function) do
    "#{__DIR__}/input.txt"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> solve_function.()
  end
end
