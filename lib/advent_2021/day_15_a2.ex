defmodule Advent2021.Day15A2 do
  def lowest_risk_amount(input) do
    grid = weight_grid(input)
    {max_x, max_y} = max_x_max_y(grid)

    grid
    |> to_graph
    |> Graph.dijkstra({0, 0}, {max_x, max_y})
    |> Enum.drop(1)
    |> Enum.reduce(0, fn each, acc -> acc + grid[each] end)
  end

  defp adjacent_coordinates(x, y, weight_grid) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.filter(fn each ->
      not is_nil(weight_grid[each])
    end)
  end

  defp to_graph(weight_grid) do
    weight_grid
    |> Enum.reduce(Graph.new(), fn {{x, y} = node, _}, graph ->
      adjacent_coordinates(x, y, weight_grid)
      |> Enum.reduce(graph, fn each, acc ->
        acc
        |> Graph.add_edge(node, each, weight: weight_grid[each])
        |> Graph.add_edge(each, node, weight: weight_grid[node])
      end)
    end)
  end

  defp digit_list(row) do
    row
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp weight_grid(input) do
    rows = String.split(input) |> Enum.map(&digit_list/1)

    for {row, x} <- Enum.with_index(rows),
        {digit, y} <- Enum.with_index(row),
        into: %{} do
      {{x, y}, digit}
    end
  end

  defp max_x_max_y(grid) do
    {{max_x, _}, _} = Enum.max_by(grid, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(grid, fn {{_, y}, _} -> y end)
    {max_x, max_y}
  end
end
