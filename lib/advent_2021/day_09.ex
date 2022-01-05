defmodule Advent2021.Day09 do
  def risk_level_sum(input) do
    map = input_to_map(input)

    for {{x, y}, digit} <- map,
        Map.get(map, {x - 1, y}) > digit,
        Map.get(map, {x + 1, y}) > digit,
        Map.get(map, {x, y - 1}) > digit,
        Map.get(map, {x, y + 1}) > digit do
      digit
    end
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  def product_of_largest_basins(input) do
    map = input_to_map(input)

    for {{x, y}, digit} <- map,
        Map.get(map, {x - 1, y}) > digit,
        Map.get(map, {x + 1, y}) > digit,
        Map.get(map, {x, y - 1}) > digit,
        Map.get(map, {x, y + 1}) > digit do
      {x, y}
    end
    |> Enum.map(fn lowpoint -> basin_size(lowpoint, map) end)
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.product()
  end

  defp basin_size(lowpoint, map) do
    flow(MapSet.new(), lowpoint, map)
    |> Enum.count()
  end

  defp flow(lava, {x, y}, map) do
    if flow_stopped?({x, y}, map, lava) do
      lava
    else
      lava
      |> MapSet.put({x, y})
      |> flow({x + 1, y}, map)
      |> flow({x - 1, y}, map)
      |> flow({x, y + 1}, map)
      |> flow({x, y - 1}, map)
    end
  end

  defp flow_stopped?(position, map, lava) do
    MapSet.member?(lava, position) || Map.get(map, position) in [nil, 9]
  end

  defp input_to_map(input) do
    rows =
      input
      |> String.split()
      |> Enum.map(&indexed_digits/1)
      |> Enum.with_index()

    for {row, x} <- rows,
        {digit, y} <- row,
        into: %{} do
      {{x, y}, digit}
    end
  end

  defp indexed_digits(row) do
    row
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
  end
end
