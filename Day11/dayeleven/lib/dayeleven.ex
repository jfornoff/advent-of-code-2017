defmodule Dayeleven do
  defmodule CubeCoordinate do
    require Integer

    def distance_from_center({cur_x, cur_y, cur_z}) do
      Enum.max([
        abs(cur_x),
        abs(cur_y),
        abs(cur_z)
      ])
    end
  end

  defmodule StepExecution do
    # Use even-q vertical layout

    require Integer
    defstruct [:coordinate, :distance_from_center]

    def initial do
      %__MODULE__{coordinate: {0, 0, 0}, distance_from_center: 0}
    end

    def run(step, %__MODULE__{coordinate: {x, y, z}}) do
      new_coordinate = new_coordinate(step, {x, y, z})

      %__MODULE__{
        coordinate: new_coordinate,
        distance_from_center: CubeCoordinate.distance_from_center(new_coordinate)
      }
    end

    defp new_coordinate(step, {x, y, z}) do
      case step do
        :n -> {x, y + 1, z - 1}
        :s -> {x, y - 1, z + 1}
        :ne -> {x + 1, y, z - 1}
        :sw -> {x - 1, y, z + 1}
        :nw -> {x - 1, y + 1, z}
        :se -> {x + 1, y - 1, z}
        foo -> raise "Unknown step #{inspect(foo)}"
      end
    end
  end

  def solve_first_part(input \\ File.read!("#{__DIR__}/input.txt")) do
    final_step =
      input
      |> parse_steps()
      |> Enum.reduce(StepExecution.initial(), &StepExecution.run/2)

    CubeCoordinate.distance_from_center(final_step.coordinate)
  end

  def solve_second_part(input \\ File.read!("#{__DIR__}/input.txt")) do
    input
    |> parse_steps()
    |> Enum.map_reduce(StepExecution.initial(), fn step, current_state ->
      result = StepExecution.run(step, current_state)
      {result, result}
    end)
    |> elem(0)
    |> Enum.map(& &1.distance_from_center)
    |> Enum.max()
  end

  defp parse_steps(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.reject(&Kernel.==(&1, ""))
    |> Enum.map(&String.to_atom/1)
  end
end
