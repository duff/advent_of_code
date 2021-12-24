defmodule Advent2021.Day06Part1 do
  def fish_count(input, days) do
    input
    |> retrieve_school
    |> go_for_days(days)
    |> Enum.count()
  end

  def go_for_days(school, 0), do: school

  def go_for_days(school, days) do
    go_for_days(increment_day(school), days - 1)
  end

  def increment_day(school) do
    school
    |> Enum.map(&transform_fish/1)
    |> List.flatten()
  end

  defp transform_fish(0), do: [6, 8]
  defp transform_fish(fish), do: fish - 1

  defp retrieve_school(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
