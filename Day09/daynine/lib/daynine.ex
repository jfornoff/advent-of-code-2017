defmodule Daynine do
  defmodule Stack do
    def empty(), do: []
    def push(stack, new_element), do: [new_element | stack]
    def pop([_discard | rest]), do: rest
    def peek([]), do: nil
    def peek(stack), do: hd(stack)
  end

  def solve_first_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    result =
      input_string
      |> String.trim()
      |> String.codepoints()
      |> Enum.reduce(%{stack: Stack.empty(), score: 0, level: 0}, &consume/2)

    result.score
  end

  def consume(_next_character, %{stack: [:discard_next_token | _]} = current) do
    %{current | stack: Stack.pop(current.stack)}
  end

  def consume(next_character, %{stack: [:open_group | _]} = current) do
    case next_character do
      "," ->
        current

      "!" ->
        %{current | stack: Stack.push(current.stack, :discard_next_token)}

      "<" ->
        %{current | stack: Stack.push(current.stack, :open_garbage)}

      "}" ->
        %{
          current
          | stack: Stack.pop(current.stack),
            score: current.score + current.level,
            level: current.level - 1
        }

      "{" ->
        %{
          current
          | stack: Stack.push(current.stack, :open_group),
            level: current.level + 1
        }
    end
  end

  def consume(next_character, %{stack: [:open_garbage | _]} = current) do
    case next_character do
      ">" -> %{current | stack: Stack.pop(current.stack)}
      "!" -> %{current | stack: Stack.push(current.stack, :discard_next_token)}
      _ -> current
    end
  end

  def consume("{", %{stack: _, score: _, level: _} = current) do
    %{current | stack: Stack.push(current.stack, :open_group), level: current.level + 1}
  end

  def solve_second_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    input_string
    |> String.trim()
    |> String.split("")
    |> count_garbage(false, 0)
  end

  def count_garbage([], _, count), do: count

  def count_garbage(["!", _ | rest], in_garbage, count) do
    count_garbage(rest, in_garbage, count)
  end

  def count_garbage(["<" | rest], false, count) do
    count_garbage(rest, true, count)
  end

  def count_garbage([_ | rest], false, count) do
    count_garbage(rest, false, count)
  end

  def count_garbage([">" | rest], true, count) do
    count_garbage(rest, false, count)
  end

  def count_garbage([_ | rest], true, count) do
    count_garbage(rest, true, count + 1)
  end
end
