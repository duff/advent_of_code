defmodule Advent2018.Day3B do
  def pristine(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&coordinates(&1))
    |> find_pristine()
  end

  defp find_pristine(list) do
    Enum.find(list, &disjoint_with_all(&1, list))
    |> elem(0)
  end

  defp disjoint_with_all({id, coordinates}, list) do
    Enum.all?(list, fn {each_id, each_coordinates} ->
      id == each_id || MapSet.disjoint?(coordinates, each_coordinates)
    end)
  end

  def coordinates(string) do
    [id, left, top, width, height] = parse_claim(string)

    values =
      for x <- (left + 1)..(left + width),
          y <- (top + 1)..(top + height),
          into: MapSet.new() do
        {x, y}
      end

    {id, values}
  end

  defp parse_claim(claim) do
    Regex.run(claim_regex(), claim, capture: :all_but_first)
    |> Enum.map(&String.to_integer(&1))
  end

  defp claim_regex do
    ~r/#(\d*) @ (\d+),(\d+): (\d+)x(\d+)/
  end
end
