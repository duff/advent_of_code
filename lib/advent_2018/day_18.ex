defmodule Advent2018.Day18 do
  def part_a(input) do
    input
    |> parse
    |> transform(10)
    |> resource_value
  end

  def part_b(input) do
    {cycle_start, cycle_end, remaining_minutes, map} =
      input
      |> parse
      |> transform_until_cycle(1_000_000_000)

    cycle_length = cycle_end - cycle_start
    needed_minutes = rem(remaining_minutes, cycle_length)

    map
    |> transform(needed_minutes)
    |> resource_value
  end

  defp resource_value(map) do
    count(map, :trees) * count(map, :lumberyard)
  end

  defp transform_until_cycle(map, times) do
    Enum.reduce_while(1..times, {map, %{}}, fn index, {acc, previous_states} ->
      transformed = transform(acc)

      if Map.has_key?(previous_states, transformed) do
        {:halt, {Map.get(previous_states, transformed), index, times - index, transformed}}
      else
        {:cont, {transformed, Map.put(previous_states, transformed, index)}}
      end
    end)
  end

  defp transform(map, times) do
    Enum.reduce(1..times, map, fn _index, acc ->
      transform(acc)
    end)
  end

  defp transform(map) do
    Enum.reduce(map, %{}, fn {coords, acre}, acc ->
      Map.put(acc, coords, new_value(acre, coords, map))
    end)
  end

  defp new_value(:open, coords, map) do
    if adjacent_count(map, coords, :trees) >= 3 do
      :trees
    else
      :open
    end
  end

  defp new_value(:trees, coords, map) do
    if adjacent_count(map, coords, :lumberyard) >= 3 do
      :lumberyard
    else
      :trees
    end
  end

  defp new_value(:lumberyard, coords, map) do
    if adjacent_count(map, coords, :lumberyard) >= 1 && adjacent_count(map, coords, :trees) >= 1 do
      :lumberyard
    else
      :open
    end
  end

  defp adjacent_count(map, coords, target) do
    Enum.count(adjacent_acres(map, coords), fn each ->
      each == target
    end)
  end

  defp adjacent_acres(map, {x, y}) do
    [
      Map.get(map, {x + 1, y}),
      Map.get(map, {x - 1, y}),
      Map.get(map, {x, y + 1}),
      Map.get(map, {x, y - 1}),
      Map.get(map, {x + 1, y + 1}),
      Map.get(map, {x - 1, y - 1}),
      Map.get(map, {x - 1, y + 1}),
      Map.get(map, {x + 1, y - 1})
    ]
  end

  defp count(map, target) do
    Enum.count(map, fn {_, acre} -> acre == target end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, &parse_line/2)
  end

  defp parse_line({line, y}, acc) do
    String.graphemes(line)
    |> Enum.with_index(1)
    |> Enum.reduce(acc, fn {char, x}, acc ->
      Map.put(acc, {x, y}, atom_for_char(char))
    end)
  end

  defp atom_for_char("."), do: :open
  defp atom_for_char("#"), do: :lumberyard
  defp atom_for_char("|"), do: :trees

  defp char_for_atom(:open), do: "."
  defp char_for_atom(:lumberyard), do: "#"
  defp char_for_atom(:trees), do: "|"

  def print(map) do
    {{_, max}, _} = Enum.max_by(map, fn {{_x, y}, _atom} -> y end)

    IO.write("\n")

    Enum.each(1..max, fn y ->
      Enum.each(1..max, fn x ->
        IO.write(Map.get(map, {x, y}) |> char_for_atom)
      end)

      IO.write("\n")
    end)

    IO.write("\n")

    map
  end
end
