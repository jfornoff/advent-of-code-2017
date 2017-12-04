defmodule Day04 do
  def solve_part_one() do
    count_valid_inputs_for(&check_for_duplicates/1)
  end

  def solve_part_two do
    count_valid_inputs_for(fn words ->
      words
      |> Enum.map(&sort_letters/1)
      |> check_for_duplicates()
    end)
  end

  defp count_valid_inputs_for(validation_function) do
    File.stream!("input.txt")
    |> Stream.filter(fn phrase ->
         words = String.split(phrase, " ") |> Enum.map(&String.trim/1)

         validation_function.(words)
       end)
    |> Enum.count()
  end

  defp check_for_duplicates(words) do
    words
    |> MapSet.new()
    |> MapSet.size()
    |> Kernel.==(length(words))
  end

  defp sort_letters(word) do
    word
    |> String.codepoints()
    |> Enum.sort()
    |> Enum.join()
  end
end
