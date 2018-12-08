defmodule Advent2018.Day3A do
  def double_booked(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&coordinates(&1))
    |> List.flatten()
    |> Enum.reduce(%{}, fn each, acc ->
      Map.update(acc, each, 1, &(&1 + 1))
    end)
    |> Enum.count(fn {_key, count} -> count > 1 end)
  end

  def coordinates(string) do
    [left, top, width, height] = parse_claim(string)

    for x <- (left + 1)..(left + width),
        y <- (top + 1)..(top + height) do
      {x, y}
    end
  end

  defp parse_claim(claim) do
    Regex.run(claim_regex(), claim, capture: :all_but_first)
    |> Enum.map(&String.to_integer(&1))
  end

  defp claim_regex do
    ~r/#\d* @ (\d+),(\d+): (\d+)x(\d+)/
  end
end
