defmodule Advent2018.Day22 do
  def part_a(depth, {x_target, y_target}) do
    for y <- 0..y_target,
        x <- 0..x_target do
      risk({x, y}, x_target, y_target, depth)
    end
    |> Enum.sum()
  end

  defp risk({x, y}, x_target, y_target, depth) do
    erosion_level({x, y}, x_target, y_target, depth)
    |> Integer.mod(3)
  end

  defp geologic_index({0, 0}, _x_target, _y_target, _depth), do: 0
  defp geologic_index({x, y}, x, y, _depth), do: 0

  defp geologic_index({x, 0}, _x_target, _y_target, _depth) do
    x * 16807
  end

  defp geologic_index({0, y}, _x_target, _y_target, _depth) do
    y * 48271
  end

  defp geologic_index({x, y}, x_target, y_target, depth) do
    erosion_level({x - 1, y}, x_target, y_target, depth) * erosion_level({x, y - 1}, x_target, y_target, depth)
  end

  defp erosion_level({x, y}, x_target, y_target, depth) do
    (geologic_index({x, y}, x_target, y_target, depth) + depth)
    |> Integer.mod(20183)
  end
end
