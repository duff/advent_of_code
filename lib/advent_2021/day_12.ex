defmodule Advent2021.Day12 do
  def path_count(input) do
    input
    |> to_edges()
    |> find_paths()
    |> Enum.count()
  end

  defp find_paths([], _edges, _route, _visited_smalls, completed) do
    completed
  end

  defp find_paths(["end" | rest], edges, route, visited_smalls, completed) do
    find_paths(rest, edges, [], visited_smalls, [["end" | route] | completed])
  end

  defp find_paths([cave | rest], edges, route, visited_smalls, completed) do
    completed =
      if cave in visited_smalls do
        completed
      else
        find_paths(edges[cave], edges, [cave | route], remember_smalls(cave, visited_smalls), completed)
      end

    find_paths(rest, edges, route, visited_smalls, completed)
  end

  defp find_paths(edges) do
    find_paths(edges["start"], edges, ["start"], ["start"], [])
  end

  defp remember_smalls(<<char, _rest::bits>> = cave, visited_smalls) when char >= ?a and char <= ?z, do: [cave | visited_smalls]
  defp remember_smalls(_cave, visited_smalls), do: visited_smalls

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
