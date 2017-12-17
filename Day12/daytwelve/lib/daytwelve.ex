defmodule Daytwelve do
  def solve_first_part(input \\ File.read!("#{__DIR__}/input.txt")) do
    input
    |> to_row_map()
    |> connected_to(MapSet.new([0]))
    |> MapSet.size()
  end

  def solve_second_part(input \\ File.read!("#{__DIR__}/input.txt")) do
    row_map = to_row_map(input)

    row_map
    |> Map.keys()
    |> Enum.map(fn key ->
      connected_to(row_map, MapSet.new([key]))
    end)
    |> Enum.uniq()
    |> length()
  end

  defp connected_to(row_map, keys) do
    new_keys =
      keys
      |> Enum.map(fn key ->
        Map.get(row_map, key, [])
      end)
      |> List.flatten()
      |> MapSet.new()

    if MapSet.equal?(keys, new_keys) do
      keys
    else
      connected_to(row_map, MapSet.union(keys, new_keys))
    end
  end

  defp to_row_map(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(%{}, &parse_row/2)
  end

  defp parse_row(row_string, row_accumulator) do
    [source_number_string, connected_numbers] =
      row_string
      |> String.split(" <-> ")

    Map.put(
      row_accumulator,
      String.to_integer(source_number_string),
      connected_numbers |> String.split(", ") |> Enum.map(&String.to_integer/1)
    )
  end
end
