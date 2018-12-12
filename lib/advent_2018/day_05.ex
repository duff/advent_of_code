defmodule Advent2018.Day05 do
  @case_diff ?a - ?A

  def num_units(charlist) do
    charlist
    |> react()
    |> length
  end

  def shortest_length(input) do
    charlist = input |> String.to_charlist()

    ?A..?Z
    |> Enum.map(fn char ->
      charlist
      |> Enum.reject(&(&1 == char || &1 == char + @case_diff))
      |> num_units()
    end)
    |> Enum.min()
  end

  def run_all_reactions(input) do
    input
    |> String.to_charlist()
    |> react()
    |> Enum.reverse()
    |> to_string()
  end

  defp react(charlist) do
    charlist
    |> Enum.reduce([], &react/2)
  end

  defp react(char, [head | tail]) when abs(char - head) == @case_diff, do: tail
  defp react(char, acc), do: [char | acc]
end
