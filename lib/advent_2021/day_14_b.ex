defmodule Advent2021.Day14B do
  def most_common_minus_least_common(input, steps) do
    {rules, frequencies} = rules_and_frequencies(input)

    {{_, mins}, {_, maxes}} =
      Enum.reduce(1..steps, frequencies, fn _step, freqs ->
        Enum.reduce(freqs, %{}, fn {[left, right] = combo, count}, acc ->
          found = Map.get(rules, combo)

          if found do
            acc
            |> Map.update([left, found], count, fn existing -> existing + count end)
            |> Map.update([found, right], count, fn existing -> existing + count end)
          else
            Map.put(acc, combo, count)
          end
        end)
      end)
      |> Enum.group_by(fn {[first, _last], _count} -> first end, fn {[_first, _last], count} -> count end)
      |> Enum.min_max_by(fn {_, counts} -> Enum.sum(counts) end)

    Enum.sum(maxes) - Enum.sum(mins)
  end

  defp rules_and_frequencies(input) do
    lines = String.split(input, "\n", trim: true)
    {[start], rule_lines} = Enum.split(lines, 1)

    rules =
      Map.new(rule_lines, fn line ->
        [left, right] = String.split(line, " -> ")
        {String.graphemes(left), right}
      end)

    frequencies =
      start
      |> String.graphemes()
      |> Enum.chunk_every(2, 1, ["unpaired"])
      |> Enum.frequencies()

    {rules, frequencies}
  end
end
