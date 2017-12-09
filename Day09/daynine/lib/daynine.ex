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
      |> Enum.reduce(%{stack: Stack.empty(), score: 0, level: 0}, fn next_character, current ->
           case Stack.peek(current.stack) do
             nil ->
               case next_character do
                 "{" ->
                   %{
                     current
                     | stack: Stack.push(current.stack, :open_group),
                       level: current.level + 1
                   }
               end

             :discard_next_token ->
               %{current | stack: Stack.pop(current.stack)}

             :open_garbage ->
               case next_character do
                 ">" -> %{current | stack: Stack.pop(current.stack)}
                 "!" -> %{current | stack: Stack.push(current.stack, :discard_next_token)}
                 _ -> current
               end

             :open_group ->
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
                   case next_character do
                     "{" ->
                       %{
                         current
                         | stack: Stack.push(current.stack, :open_group),
                           level: current.level + 1
                       }
                   end
               end
           end
         end)

    result.score
  end
end
