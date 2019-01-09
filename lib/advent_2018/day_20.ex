defmodule Advent2018.Day20 do
  def part_a(input) do
    input
    |> parse
    |> execute(%{})
    |> largest_door_count
  end

  def part_b(input) do
    input
    |> parse
    |> execute(%{})
    |> Enum.filter(fn {_coord, distance} -> distance >= 1000 end)
    |> Enum.count()
  end

  defp parse(input) do
    String.graphemes(input)
  end

  defp execute(["^" | rest], map) do
    execute(rest, map, {0, 0}, 1, [])
  end

  defp execute(["$" | _rest], map, _coord, _distance, _memory) do
    map
  end

  defp execute(["(" | rest], map, coord, distance, memory) do
    execute(rest, map, coord, distance, [{coord, distance} | memory])
  end

  defp execute([")" | rest], map, _old_coord, _old_distance, [{coord, distance} | memory]) do
    execute(rest, map, coord, distance, memory)
  end

  defp execute(["|" | rest], map, _old_coord, _old_distance, [{coord, distance} | _rest_memory] = memory) do
    execute(rest, map, coord, distance, memory)
  end

  defp execute([direction | rest], map, coord, distance, memory) do
    next_coord = determine_coordinate(direction, coord)
    new_map = Map.update(map, next_coord, distance, &min(distance, &1))
    execute(rest, new_map, next_coord, distance + 1, memory)
  end

  defp determine_coordinate("N", {x, y}), do: {x, y - 1}
  defp determine_coordinate("S", {x, y}), do: {x, y + 1}
  defp determine_coordinate("W", {x, y}), do: {x - 1, y}
  defp determine_coordinate("E", {x, y}), do: {x + 1, y}

  defp largest_door_count(map) do
    {_, distance} = Enum.max_by(map, fn {_coord, distance} -> distance end)
    distance
  end
end
