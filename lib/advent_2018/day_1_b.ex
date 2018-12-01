defmodule Advent2018.Day1B do
  def first_duplicate(input) do
    input
    |> as_integers()
    |> find_duplicate()
  end

  defp find_duplicate(original_input) do
    do_find_duplicate(original_input, 0, MapSet.new(), original_input)
  end

  defp do_find_duplicate([next | rest], current_frequency, past_frequencies, original_input) do
    if MapSet.member?(past_frequencies, current_frequency) do
      current_frequency
    else
      do_find_duplicate(
        rest,
        current_frequency + next,
        MapSet.put(past_frequencies, current_frequency),
        original_input
      )
    end
  end

  defp do_find_duplicate([], current_frequency, past_frequencies, original_input) do
    do_find_duplicate(original_input, current_frequency, past_frequencies, original_input)
  end

  defp as_integers(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
