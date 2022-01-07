defmodule Advent2021.Day11 do
  def flashes(input) do
    grid = input_to_grid(input)

    Enum.reduce(1..100, {0, grid}, fn _step, {count, grid} ->
      {additional_flashes, grid} = step(grid)
      {additional_flashes + count, grid}
    end)
    |> elem(0)
  end

  defp step(grid) do
    after_all_flashing = grid |> inc_all_values() |> find_and_inc_adjacent_flashes()

    marked = Map.filter(after_all_flashing, fn {_, value} -> value == "*" end)
    {map_size(marked), reset_marked(after_all_flashing, marked)}
  end

  defp find_and_inc_adjacent_flashes(grid) do
    just_flashed = Map.filter(grid, fn {_, value} -> value == 10 end)
    grid = grid |> inc_adjacent_flashes(just_flashed) |> mark_just_flashed(just_flashed)

    if Enum.any?(grid, fn {_, value} -> value == 10 end) do
      find_and_inc_adjacent_flashes(grid)
    else
      grid
    end
  end

  defp inc_adjacent_flashes(grid, just_flashed) do
    Enum.reduce(Map.keys(just_flashed), grid, fn {x, y}, acc ->
      Enum.reduce(adjacent_coordinates({x, y}), acc, fn coord, acc ->
        Map.update(acc, coord, nil, &inc_existing_val/1)
      end)
    end)
  end

  defp mark_just_flashed(grid, just_flashed) do
    just_flashed
    |> Map.keys()
    |> Enum.reduce(grid, fn {x, y}, acc -> Map.replace!(acc, {x, y}, "*") end)
  end

  defp inc_all_values(grid) do
    Enum.reduce(Map.keys(grid), grid, fn key, acc ->
      Map.update!(acc, key, &inc_existing_val/1)
    end)
  end

  defp inc_existing_val(nil), do: nil
  defp inc_existing_val("*"), do: "*"
  defp inc_existing_val(10), do: 10
  defp inc_existing_val(val), do: val + 1

  defp adjacent_coordinates({x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}, {x - 1, y - 1}, {x + 1, y + 1}, {x - 1, y + 1}, {x + 1, y - 1}]
  end

  defp reset_marked(grid, marked) do
    Enum.reduce(Map.keys(marked), grid, fn key, acc -> Map.replace!(acc, key, 0) end)
  end

  defp input_to_grid(input) do
    rows = String.split(input) |> Enum.map(&digit_list/1)

    for {row, x} <- Enum.with_index(rows),
        {digit, y} <- Enum.with_index(row),
        into: %{} do
      {{x, y}, digit}
    end
  end

  defp digit_list(row) do
    row
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  # defp show_grid(grid) do
  #   IO.puts("")

  #   for x <- 0..9 do
  #     IO.inspect(Enum.map(0..9, fn y -> Map.get(grid, {x, y}) end))
  #   end
  # end
end
