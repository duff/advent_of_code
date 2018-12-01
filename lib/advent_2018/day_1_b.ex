defmodule Advent2018.Day1B do
  def first_duplicate(input) do
    input
    |> as_integers()
    |> do_first_duplicate()
  end

  defp do_first_duplicate(original_deltas) do
    do_first_duplicate(original_deltas, 0, MapSet.new(), original_deltas)
  end

  defp do_first_duplicate([next | rest], current_frequency, past_frequencies, original_deltas) do
    if MapSet.member?(past_frequencies, current_frequency) do
      current_frequency
    else
      do_first_duplicate(
        rest,
        current_frequency + next,
        MapSet.put(past_frequencies, current_frequency),
        original_deltas
      )
    end
  end

  defp do_first_duplicate([], current_frequency, past_frequencies, original_deltas) do
    do_first_duplicate(original_deltas, current_frequency, past_frequencies, original_deltas)
  end

  defp as_integers(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
