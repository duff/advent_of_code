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
