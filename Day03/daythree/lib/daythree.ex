defmodule Daythree.PartOne do
  def solve(target_square) do
    do_solve(target_square)
  end

  defp do_solve(1), do: 0

  defp do_solve(target_square) do
    # Based on that the outward circle corners always need 2 * circle width steps
    # to reach the center square, while the fields between corners are closer
    # with the center between the corners being the closest to the center.
    circle_no(target_square) * 2 - distance_to_nearest_corner(target_square)
  end

  # The bottom right square in a circle has the highest numerical value,
  # therefore we can just keep looking up new right corners until we find one
  # that has a larger value than the square we're looking at
  defp circle_no(target_square) do
    bottom_right_corners()
    |> Stream.take_while(fn bottom_right_square ->
         target_square > bottom_right_square
       end)
    |> Enum.to_list()
    |> length()
  end

  defp distance_to_nearest_corner(target_square) do
    target_square
    |> circle_no()
    |> corners_of_circle()
    |> find_adjacent_corners(target_square)
    |> min_distance_to_corner(target_square)
  end

  defp find_adjacent_corners(corners, target_square) do
    corners
    |> Enum.zip(Enum.drop(corners, 1))
    |> Enum.find(fn {lower_corner, higher_corner} ->
         lower_corner <= target_square && higher_corner >= target_square
       end)
  end

  defp min_distance_to_corner({lower_corner, higher_corner}, target_square) do
    Enum.min([
      abs(lower_corner - target_square),
      abs(higher_corner - target_square)
    ])
  end

  defp bottom_right_corners() do
    Stream.iterate(1, &(&1 + 2))
    |> Stream.map(&:math.pow(&1, 2))
  end

  def corners_of_circle(circle_no) do
    bottom_right_corner = bottom_right_corners() |> Enum.at(circle_no)

    [
      bottom_right_corner - 8 * circle_no,
      bottom_right_corner - 6 * circle_no,
      bottom_right_corner - 4 * circle_no,
      bottom_right_corner - 2 * circle_no,
      bottom_right_corner
    ]
  end
end
