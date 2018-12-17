defmodule Advent2018.Day11 do
  def part_a(serial_number) do
    {{found, _}, _} = largest_power_grid(300, 3, 3, serial_number)
    found
  end

  def part_b(serial_number) do
    {{{x, y}, size}, _} = largest_power_grid(300, 1, 300, serial_number)
    {x, y, size}
  end

  def power_level({x, y}, serial_number) do
    rack_id = x + 10
    power_level = (rack_id * y + serial_number) * rack_id

    power_level
    |> div(100)
    |> rem(10)
    |> Kernel.-(5)
  end

  def summed_area_table(grid_size, input_table) do
    for y <- 1..grid_size, x <- 1..grid_size do
      {x, y}
    end
    |> Enum.reduce(%{}, fn {x, y}, acc ->
      value = summed_area_position(x, y, input_table, acc)
      Map.put(acc, {x, y}, value)
    end)
  end

  defp summed_area_position(x, y, input_table, summed_area_table) do
    a = Map.get(input_table, {x, y})
    b = Map.get(summed_area_table, {x, y - 1}, 0)
    c = Map.get(summed_area_table, {x - 1, y}, 0)
    d = Map.get(summed_area_table, {x - 1, y - 1}, 0)

    a + b + c - d
  end

  defp largest_power_grid(max_grid_size, min_area_size, max_area_size, serial_number) do
    table = generate_summed_area_table(max_grid_size, serial_number)

    for y <- 1..max_grid_size,
        x <- 1..max_grid_size,
        size <- min_area_size..max_area_size,
        x + size <= max_grid_size,
        y + size <= max_grid_size do
      {{{x, y}, size}, power_level_of_grid(x, y, size, table)}
    end
    |> Enum.max_by(fn {_, power_level} -> power_level end)
  end

  defp power_level_of_grid(x, y, size, table) do
    a = Map.get(table, {x - 1, y - 1}, 0)
    b = Map.get(table, {x - 1 + size, y - 1}, 0)
    c = Map.get(table, {x - 1, y + size - 1}, 0)
    d = Map.get(table, {x + size - 1, y + size - 1}, 0)
    d + a - b - c
  end

  defp power_levels(grid_size, serial_number) do
    for y <- 1..grid_size,
        x <- 1..grid_size,
        into: %{} do
      {{x, y}, power_level({x, y}, serial_number)}
    end
  end

  defp generate_summed_area_table(max_grid_size, serial_number) do
    power_levels = power_levels(max_grid_size, serial_number)
    summed_area_table(max_grid_size, power_levels)
  end
end
