defmodule Advent2023.Day01 do
  def calibration_value(input) do
    digit_string = digits(input)

    "#{String.first(digit_string)}#{String.last(digit_string)}"
    |> String.to_integer()
  end

  def calibration_sum(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value/1)
    |> Enum.sum()
  end

  defp digits(str) do
    str
    |> String.to_charlist()
    |> Enum.filter(fn x -> x in ?0..?9 end)
    |> List.to_string()
  end
end
