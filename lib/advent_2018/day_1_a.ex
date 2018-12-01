defmodule Advent2018.Day1A do
  def calibrate(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum()
  end
end
