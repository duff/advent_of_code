defmodule Advent2018.Day01B do
  def first_duplicate(input) do
    input
    |> as_integers()
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn each, {current_frequency, past_frequencies} ->
      new_frequency = current_frequency + each

      if new_frequency in past_frequencies do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, MapSet.put(past_frequencies, new_frequency)}}
      end
    end)
  end

  defp as_integers(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
  end
end
