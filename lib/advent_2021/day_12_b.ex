defmodule Advent2021.Day12B.Visited do
  alias Advent2021.Day12B.Visited

  defstruct once: MapSet.new(), twice: MapSet.new(["start"])

  def new() do
    %Visited{}
  end

  def remember(visited, <<char, _rest::bits>> = cave) when char >= ?a and char <= ?z do
    if !MapSet.member?(visited.once, cave) do
      %{visited | once: MapSet.put(visited.once, cave)}
    else
      %{visited | twice: MapSet.put(visited.twice, cave)}
    end
  end

  def remember(visited, _cave), do: visited

  def done?(visited, cave) do
    MapSet.member?(visited.twice, cave) || (twice_reached?(visited) && MapSet.member?(visited.once, cave))
  end

  defp twice_reached?(visited) do
    MapSet.size(visited.twice) > 1
  end
end

defmodule Advent2021.Day12B do
  alias Advent2021.Day12B.Visited

  def path_count(input) do
    input
    |> to_edges()
    |> find_paths()
    |> Enum.count()
  end

  defp find_paths([], _edges, _route, _visited_smalls, completed) do
    completed
  end

  defp find_paths(["end" | rest], edges, route, visited, completed) do
    find_paths(rest, edges, [], visited, [["end" | route] | completed])
  end

  defp find_paths([cave | rest], edges, route, visited, completed) do
    completed =
      if Visited.done?(visited, cave) do
        completed
      else
        find_paths(edges[cave], edges, [cave | route], Visited.remember(visited, cave), completed)
      end

    find_paths(rest, edges, route, visited, completed)
  end

  defp find_paths(edges) do
    find_paths(edges["start"], edges, ["start"], Visited.new(), [])
  end

  defp to_edges(input) do
    input
    |> String.split()
    |> Enum.reduce(Map.new(), fn line, acc ->
      [left, right] = String.split(line, "-")

      acc
      |> Map.update(left, [right], fn existing -> [right | existing] end)
      |> Map.update(right, [left], fn existing -> [left | existing] end)
    end)
  end
end
