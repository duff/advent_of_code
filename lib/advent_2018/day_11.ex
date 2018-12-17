defmodule Advent2018.Day11 do
  @grid_size 300

  def power_level({x, y}, serial_number) do
    rack_id = x + 10
    power_level = (rack_id * y + serial_number) * rack_id
    hundreds_digit(power_level) - 5
  end

  def largest_power_grid_of_nine(serial_number) do
    [{found, _}, _] =
      for y <- 1..(@grid_size - 3),
          x <- 1..(@grid_size - 3) do
        grid = {{x, y}, {x + 2, y + 2}}
        [grid, power_level_of_grid(grid, serial_number)]
      end
      |> Enum.max_by(fn [_, power_level] -> power_level end)

    found
  end

  def largest_power_grid(serial_number) do
    found =
      for y <- 1..@grid_size,
          x <- 1..@grid_size,
          size <- 1..@grid_size,
          x + size <= @grid_size,
          y + size <= @grid_size do
        grid = {{x, y}, {x + size, y + size}}
        %{x: x, y: y, size: 1 + size, total_power: power_level_of_grid(grid, serial_number)}
      end
      |> Enum.max_by(fn each -> Map.get(each, :total_power) end)

    {found.x, found.y, found.size}
  end

  defp power_level_of_grid({{top_left_x, top_left_y}, {bottom_right_x, bottom_right_y}}, serial_number) do
    for x <- top_left_x..bottom_right_x,
        y <- top_left_y..bottom_right_y do
      {x, y}
    end
    |> Enum.reduce(0, fn each, acc -> acc + power_level(each, serial_number) end)
  end

  defp hundreds_digit(number) do
    number
    |> Integer.to_string()
    |> String.codepoints()
    |> Enum.reverse()
    |> Enum.at(2, "0")
    |> String.to_integer()
  end
end
