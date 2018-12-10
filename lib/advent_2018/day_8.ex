defmodule Advent2018.Tree do
  defstruct children: [], meta: []

  alias Advent2018.Tree

  def new do
    %Tree{}
  end
end

defmodule Advent2018.Day8 do
  alias Advent2018.Tree

  def metadata_sum(input) do
    input
    |> tree
    |> retrieve_meta([])
    |> Enum.sum()
  end

  def root_node_value(input) do
    input
    |> tree
    |> retrieve_value()
  end

  def tree(input) do
    {tree, []} =
      input
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> build_tree()

    tree
  end

  defp build_tree([child_count, meta_count | rest]) do
    {tree, rest} = add_childen_to_tree(child_count, rest, Tree.new())
    {meta, rest} = Enum.split(rest, meta_count)

    {%{tree | meta: meta}, rest}
  end

  defp add_childen_to_tree(0, rest, tree) do
    tree = Map.update!(tree, :children, fn value -> Enum.reverse(value) end)
    {tree, rest}
  end

  defp add_childen_to_tree(num, rest, tree) do
    {child, rest} = build_tree(rest)

    tree = Map.update!(tree, :children, fn value -> [child | value] end)
    add_childen_to_tree(num - 1, rest, tree)
  end

  defp retrieve_meta(%Tree{meta: meta, children: []}, acc) do
    acc ++ meta
  end

  defp retrieve_meta(%Tree{meta: meta, children: children}, acc) do
    Enum.reduce(children, acc, fn child, acc ->
      retrieve_meta(child, acc)
    end) ++ meta
  end

  defp retrieve_value(%Tree{meta: meta, children: []}) do
    Enum.sum(meta)
  end

  defp retrieve_value(%Tree{meta: meta, children: children}) do
    Enum.reduce(meta, 0, fn index, acc ->
      value_at_index(children, index) + acc
    end)
  end

  defp value_at_index(children, index) do
    case Enum.at(children, index - 1) do
      nil -> 0
      child -> retrieve_value(child)
    end
  end
end
