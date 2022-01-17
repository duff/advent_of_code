defmodule Advent2021.Day15B2 do
  def lowest_risk_amount(input) do
    grid = grown_weight_grid(input)

    distances = go(grid, {0, 0}, %{}, MapSet.new())
    {max_x, max_y} = max_x_max_y(distances)
    distances[{max_x, max_y}]
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

  defp go(weight_grid, node = {0, 0}, distances, visited) do
    go(weight_grid, Map.put(distances, node, 0), MapSet.put(visited, node))
  end

  defp go(weight_grid, distances, visited) do
    nodes_to_assess = adjacent_nodes_and_distances(visited, weight_grid, distances)
    updated_distances = update_adjacent_distances(nodes_to_assess, distances)

    updated_distances
    # |> print(false)
    |> Map.filter(fn {node, _distance} -> !MapSet.member?(visited, node) end)
    |> assess_available_and_go(weight_grid, updated_distances, visited)
  end

  defp assess_available_and_go(available, _weight_grid, distances, _visited) when map_size(available) == 0 do
    distances
  end

  defp assess_available_and_go(available, weight_grid, distances, visited) do
    {min_node, _distance} = Enum.min_by(available, fn {_node, distance} -> distance end)
    go(weight_grid, distances, MapSet.put(visited, min_node))
  end

  defp update_adjacent_distances(nodes_to_assess, distances) do
    Enum.reduce(nodes_to_assess, distances, fn {node, distance}, acc ->
      Map.update(acc, node, distance, fn existing -> Enum.min([existing, distance]) end)
    end)
  end

  defp adjacent_nodes_and_distances(visited, weight_grid, distances) do
    Enum.flat_map(visited, fn from_node = {x, y} ->
      adjacent_coordinates(x, y)
      |> Enum.filter(fn each -> Map.has_key?(weight_grid, each) && !MapSet.member?(visited, each) end)
      |> Enum.map(fn adjacent_node -> {adjacent_node, weight_grid[adjacent_node] + distances[from_node]} end)
    end)
  end

  defp adjacent_coordinates(x, y) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
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

  defp max_x_max_y(grid) do
    {{max_x, _}, _} = Enum.max_by(grid, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(grid, fn {{_, y}, _} -> y end)
    {max_x, max_y}
  end
end
