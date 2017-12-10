defmodule Dayten do
  import Bitwise
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
      |> run_round(list)

    [first_item, second_item | _] = result.current_list
    first_item * second_item
  end

  defp run_round(lengths, input) do
    lengths
    |> Enum.reduce(Iteration.initial(input), fn swap_length, iteration ->
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

  def solve_second_part(lengths \\ @lengths_input) do
    lengths
    |> to_bytes
    |> append_predefined_lengths
    |> compute_sparse_hash(0..255 |> Enum.into([]))
    |> compute_dense_hash
    |> format_hexadecimal
  end

  defp to_bytes(lengths) do
    to_charlist(lengths)
  end

  defp append_predefined_lengths(lengths) do
    lengths ++ [17, 31, 73, 47, 23]
  end

  defp compute_sparse_hash(lengths, start_list) do
    result =
      lengths
      |> Stream.cycle()
      |> Enum.take(length(lengths) * 64)
      |> run_round(start_list)

    result.current_list
  end

  defp compute_dense_hash(sparse_hash) do
    sparse_hash
    |> Enum.chunk_every(16)
    |> Enum.map(&xor_elements/1)
  end

  defp xor_elements(elements) do
    Enum.reduce(elements, 0, &(&1 ^^^ &2))
  end

  defp format_hexadecimal(elements) do
    elements
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
    |> Enum.map(&String.downcase/1)
    |> Enum.join()
  end
end
