defmodule Advent2023.Day01 do
  def calibration_value(input) do
    input
    |> digits_only()
    |> first_last()
  end

  def calibration_value_with_words(input) do
    input
    |> digits_with_words()
    |> first_last()
  end

  def calibration_sum(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value/1)
    |> Enum.sum()
  end

  def calibration_sum_with_words(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value_with_words/1)
    |> Enum.sum()
  end

  defp digits_only(str) do
    Regex.scan(~r{[1-9]}, str)
    |> List.flatten()
  end

  defp digits_with_words(str) do
    Regex.scan(~r{\d|oneight|twone|eightwo|nineight|eighthree|one|two|three|four|five|six|seven|eight|nine}, str)
    |> Enum.map(&to_digits/1)
    |> List.flatten()
  end

  defp first_last(list) do
    "#{List.first(list)}#{List.last(list)}"
    |> String.to_integer()
  end

  defp to_digits([str]) do
    case str do
      "oneight" -> [1, 8]
      "twone" -> [2, 1]
      "eightwo" -> [8, 2]
      "nineight" -> [9, 8]
      "eighthree" -> [8, 3]
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
      _ -> String.to_integer(str)
    end
  end
end
