defmodule Advent2021.Day14A do
  def insert_pairs(input, steps) do
    lines = String.split(input, "\n", trim: true)
    {[start], rule_lines} = Enum.split(lines, 1)
    rules = Map.new(rule_lines, fn e -> String.split(e, " -> ") |> List.to_tuple() end)

    1..steps
    |> Enum.reduce(start, fn _, acc ->
      acc
      |> String.graphemes()
      |> Enum.chunk_every(2, 1)
      |> step(rules, [])
      |> Enum.join()
    end)
  end

  def most_common_minus_least_common(input, steps) do
    {{_, min}, {_, max}} =
      input
      |> insert_pairs(steps)
      |> String.graphemes()
      |> Enum.frequencies()
      |> Enum.min_max_by(fn {_, y} -> y end)

    max - min
  end

  defp step([[part_one, part_two] | rest], rules, result) do
    step(rest, rules, [[part_one, rules[part_one <> part_two]] | result])
  end

  defp step([[last]], rules, result), do: step([], rules, [last | result])
  defp step([], _rules, result), do: Enum.reverse(result)
end
