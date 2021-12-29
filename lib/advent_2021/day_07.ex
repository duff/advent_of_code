defmodule Advent2021.Day07 do
  def minimum_fuel(input, options \\ []) do
    incrementing = Keyword.get(options, :incrementing, false)
    list = input_to_list(input)

    list
    |> full_range
    |> Enum.map(fn each -> fuel_to_reach(list, each, incrementing) end)
    |> Enum.min()
  end

  defp input_to_list(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp full_range(list) do
    {min, max} = Enum.min_max(list)
    min..max
  end

  defp fuel_to_reach(list, position, false) do
    list
    |> Enum.map(&abs(position - &1))
    |> Enum.sum()
  end

  defp fuel_to_reach(list, position, true) do
    list
    |> Enum.map(fn e ->
      val = abs(position - e)
      val * (val + 1) / 2
    end)
    |> Enum.sum()
  end
end
