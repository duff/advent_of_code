defmodule Advent2018.Day2A do
  def checksum(input) do
    twos_count(input) * threes_count(input)
  end

  def twos_count(input) do
    input
    |> String.split()
    |> Enum.count(&two?(&1))
  end

  def threes_count(input) do
    input
    |> String.split()
    |> Enum.count(&three?(&1))
  end

  def two?(input) do
    input
    |> counts()
    |> Enum.member?(2)
  end

  def three?(input) do
    input
    |> counts()
    |> Enum.member?(3)
  end

  defp counts(input) do
    input
    |> String.graphemes()
    |> Enum.group_by(&(&1))
    |> Map.values()
    |> Enum.map(&Enum.count/1)
  end
end
