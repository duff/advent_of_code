defmodule Advent2021.Day06B do
  def fish_count(input, days) do
    input
    |> retrieve_school
    |> propagate(days)
    |> Enum.sum()
  end

  def propagate(school, 0), do: school

  def propagate([zero, one, two, three, four, five, six, seven, eight], days) do
    propagate([one, two, three, four, five, six, seven + zero, eight, zero], days - 1)
  end

  defp retrieve_school(input) do
    0..8
    |> Map.new(fn x -> {x, 0} end)
    |> Map.merge(initial_school(input))
    |> Map.values()
  end

  defp initial_school(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
