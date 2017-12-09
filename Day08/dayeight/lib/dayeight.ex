defmodule Dayeight do
  defmodule Instruction do
    defstruct [
      :target_register,
      :operation_function,
      :condition_register,
      :condition_function
    ]

    def from_string(input_string) do
      parsed_values =
        ~r/(?<target_register>.+) (?<target_operation>(inc|dec)) (?<target_argument>-?\d+) if (?<condition_register>.*) (?<condition_operator>.+) (?<condition_value>-?\d+)$/
        |> Regex.named_captures(input_string)

      %__MODULE__{
        target_register: Map.fetch!(parsed_values, "target_register"),
        operation_function:
          operation_fn(
            Map.fetch!(parsed_values, "target_operation"),
            Map.fetch!(parsed_values, "target_argument") |> String.to_integer()
          ),
        condition_register: Map.fetch!(parsed_values, "condition_register"),
        condition_function:
          condition_fn(
            Map.fetch!(parsed_values, "condition_operator"),
            Map.fetch!(parsed_values, "condition_value") |> String.to_integer()
          )
      }
    end

    def operation_fn("inc", how_much), do: &Kernel.+(&1, how_much)
    def operation_fn("dec", how_much), do: &Kernel.-(&1, how_much)

    def condition_fn(">", comparison_value), do: &Kernel.>(&1, comparison_value)
    def condition_fn("<", comparison_value), do: &Kernel.<(&1, comparison_value)
    def condition_fn(">=", comparison_value), do: &Kernel.>=(&1, comparison_value)
    def condition_fn("<=", comparison_value), do: &Kernel.<=(&1, comparison_value)
    def condition_fn("==", comparison_value), do: &Kernel.==(&1, comparison_value)
    def condition_fn("!=", comparison_value), do: &Kernel.!=(&1, comparison_value)

    def execute(registers, %__MODULE__{} = instruction) do
      should_execute? =
        instruction.condition_function.(Map.fetch!(registers, instruction.condition_register))

      if should_execute? do
        Map.update!(
          registers,
          instruction.target_register,
          instruction.operation_function
        )
      else
        registers
      end
    end
  end

  @doc """
  This parses a list of instructions out of the input string
  and sequentially executes them, initializing newly occurring registers
  to 0. It then finds the highest register value and returns it.
  """
  def solve_first_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    input_string
    |> parse_instruction_list()
    |> execution_history()
    |> latest_iteration_maximal_register_value()
  end

  def solve_second_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    input_string
    |> parse_instruction_list()
    |> execution_history()
    |> all_time_maximal_register_value
  end

  defp parse_instruction_list(input_string) do
    input_string
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&Instruction.from_string/1)
  end

  defp execution_history(instruction_list) do
    instruction_list
    |> Enum.reduce([%{}], fn instruction, [registers | _] = history ->
         new_registers =
           registers
           |> Map.put_new(instruction.target_register, 0)
           |> Map.put_new(instruction.condition_register, 0)
           |> Instruction.execute(instruction)

         [new_registers | history]
       end)
  end

  defp latest_iteration_maximal_register_value(execution_history) do
    execution_history
    |> hd()
    |> Map.values()
    |> Enum.max()
  end

  defp all_time_maximal_register_value(execution_history) do
    execution_history
    |> Enum.map(&Map.values/1)
    |> List.flatten()
    |> Enum.max()
  end
end
