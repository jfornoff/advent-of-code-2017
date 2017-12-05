defmodule Dayfive do
  defmodule JumpIteration do
    defstruct [:jumplist, :current_position, :steps_taken]

    def initial(list) do
      %JumpIteration{jumplist: list, current_position: 0, steps_taken: 0}
    end

    def next_iteration(%JumpIteration{} = iteration) do
      updated_jumplist =
        iteration.jumplist
        |> List.update_at(iteration.current_position, &(&1 + 1))

      updated_position =
        iteration.current_position + Enum.at(iteration.jumplist, iteration.current_position)

      %JumpIteration{
        jumplist: updated_jumplist,
        current_position: updated_position,
        steps_taken: iteration.steps_taken + 1
      }
    end
  end

  def solve_first_from_input() do
    "#{__DIR__}/input.txt"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> solve_first
  end

  def solve_first(list) do
    list
    |> JumpIteration.initial()
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
end
