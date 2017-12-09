defmodule Dayseven do
  @moduledoc """
  I found the naming in the Example a little obnoxious, the glossary:
  "Program" : Node
  "Sub-tower" : Subtree
  """
  defmodule Node do
    defstruct [:name, :weight, :subtree]

    def total_weight(%__MODULE__{} = node) do
      node.weight + subtree_total_weight(node)
    end

    defp subtree_total_weight(node) do
      node.subtree
      |> Enum.map(&total_weight/1)
      |> Enum.sum()
    end
  end

  defmodule Tree do
    defstruct [:root]

    def construct(input_string) do
      input_string
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_raw_node/1)
      |> build_tree()
    end

    defp parse_raw_node(node_string) do
      captures =
        Regex.named_captures(
          ~r/(?<name>.*) \((?<weight>\d+)\)( -> (?<subtree>.*))?$/,
          node_string
        )

      %Node{
        name: Map.fetch!(captures, "name"),
        weight: Map.fetch!(captures, "weight") |> String.to_integer(),
        subtree:
          Map.fetch!(captures, "subtree")
          |> case do
               "" -> []
               subtree -> subtree |> String.split(", ")
             end
      }
    end

    defp build_tree(raw_nodes) do
      find_root_node(raw_nodes)
      |> build_subtree_from_root(raw_nodes)
    end

    @doc """
    A node is considered the root if it has nodes in its subtree and is not part of
    another subtree. This ignores the case of a root-only tree.
    """
    defp find_root_node(raw_nodes) do
      raw_nodes
      |> Enum.find(fn node ->
           node.subtree != [] &&
             Enum.all?(raw_nodes, fn other_node ->
               not Enum.member?(other_node.subtree, node.name)
             end)
         end)
    end

    @doc """
    Replaces the node names in the "raw node"'s above nodes with its actual
    node struct equivalient and builds their subtrees recursively
    """
    defp build_subtree_from_root(subtree_root, raw_nodes) do
      subtree_root
      |> Map.update!(:subtree, fn above_node_names ->
           above_node_names
           |> Enum.map(fn above_node_name ->
                above_node_name
                |> find_node_by_name(raw_nodes)
                |> build_subtree_from_root(raw_nodes)
              end)
         end)
    end

    defp find_node_by_name(node_name, raw_nodes) do
      Enum.find(raw_nodes, fn raw_node -> raw_node.name == node_name end)
    end
  end

  # FIRST PART SOLUTION
  def solve_first_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    Tree.construct(input_string).name
  end

  # SECOND PART SOLUTION
  def solve_second_part(input_string \\ File.read!("#{__DIR__}/input.txt")) do
    root_node = input_string |> Tree.construct()

    find_adjusted_weight_to_balance(root_node)
  end

  # Second part functions

  @doc """
  This steps into the tree and looks for an imbalanced node (a node is "imbalanced"
  when its total weight (own weight + total weight of its subtree) does not match
  the common weight of its siblings in the subtree.
  """
  defp find_adjusted_weight_to_balance(tree_root) do
    if all_weights_equal?(tree_root.subtree) do
      nil
    else
      do_find_adjusted_weight_to_balance(
        imbalanced_node(tree_root.subtree),
        common_weight(tree_root.subtree)
      )
    end
  end

  @doc """
  When we call this, we know that the imbalance is in this subtree.
  If the subtree nodes are all the same weight, we need to adjust the root weight
  to accommodate the total weight that we're trying to achieve.
  """
  defp do_find_adjusted_weight_to_balance(subtree_root, desired_total_weight) do
    if all_weights_equal?(subtree_root.subtree) do
      delta_to_desired_weight = desired_total_weight - Node.total_weight(subtree_root)
      subtree_root.weight + delta_to_desired_weight
    else
      do_find_adjusted_weight_to_balance(
        imbalanced_node(subtree_root.subtree),
        common_weight(subtree_root.subtree)
      )
    end
  end

  defp all_weights_equal?([]), do: true

  defp all_weights_equal?(nodes) do
    nodes
    |> Enum.map(&Node.total_weight/1)
    |> Enum.uniq()
    |> length()
    |> Kernel.==(1)
  end

  defp imbalanced_node(nodes) do
    nodes
    |> Enum.find(fn node ->
         Node.total_weight(node) != common_weight(nodes)
       end)
  end

  @doc """
  The weight that we're trying to achieve for an imbalanced node is dependent
  on what total weight the most of its siblings have in common.
  """
  defp common_weight(nodes) do
    nodes
    |> Enum.group_by(&Node.total_weight/1)
    |> Enum.max_by(fn {_weight, nodes} ->
         length(nodes)
       end)
    |> elem(0)
  end
end
