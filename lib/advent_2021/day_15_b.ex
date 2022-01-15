defmodule Advent2021.Day15B do
  def lowest_risk_amount(input) do
    grid = grown_weight_grid(input)

    {max_x, max_y} = max_x_max_y(grid)

    grid
    |> to_graph
    |> Graph.dijkstra({0, 0}, {max_x, max_y})
    |> Enum.drop(1)
    |> Enum.reduce(0, fn each, acc -> acc + grid[each] end)
  end

  defp grown_weight_grid(input) do
    input
    |> weight_grid
    |> grow_right
    |> grow_down
  end

  defp grow_right(grid) do
    {_max_x, max_y} = max_x_max_y(grid)

    Enum.reduce(1..4, grid, fn _step, acc ->
      Enum.reduce(acc, acc, fn {{x, y}, weight}, result_acc ->
        result_acc
        |> Map.put({x, y + max_y + 1}, new_weight(weight + 1))
      end)
    end)
  end

  defp grow_down(grid) do
    {max_x, _max_y} = max_x_max_y(grid)

    Enum.reduce(1..4, grid, fn _step, acc ->
      Enum.reduce(acc, acc, fn {{x, y}, weight}, result_acc ->
        result_acc
        |> Map.put({x + max_x + 1, y}, new_weight(weight + 1))
      end)
    end)
  end

  defp new_weight(10), do: 1
  defp new_weight(value), do: value

  defp adjacent_coordinates({x, y}, weight_grid) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.filter(fn each ->
      not is_nil(weight_grid[each])
    end)
  end

  defp to_graph(weight_grid) do
    weight_grid
    |> Enum.reduce(Graph.new(), fn {node, _}, graph ->
      add_edges_for_node(graph, node, weight_grid)
    end)
  end

  defp add_edges_for_node(graph, node, weight_grid) do
    node
    |> adjacent_coordinates(weight_grid)
    |> Enum.reduce(graph, fn each_adjacent, acc ->
      acc
      |> Graph.add_edge(node, each_adjacent, weight: weight_grid[each_adjacent])
      |> Graph.add_edge(each_adjacent, node, weight: weight_grid[node])
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

  # defp print(grid, show_values \\ true) do
  #   {max_x, max_y} = max_x_max_y(grid)

  #   IO.puts("")

  #   for x <- 0..max_x do
  #     for y <- 0..max_y do
  #       value = Map.get(grid, {x, y})

  #       if is_nil(value) do
  #         IO.write(String.pad_leading(" ", 1))
  #       else
  #         if show_values do
  #           IO.write(String.pad_leading(Integer.to_string(value), 3))
  #         else
  #           IO.write(String.pad_leading("*", 1))
  #         end
  #       end
  #     end

  #     IO.write("\n")
  #   end

  #   IO.puts("")
  #   grid
  # end
end
