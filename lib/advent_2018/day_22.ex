defmodule Advent2018.Day22.Survey do
  defstruct x_target: nil, y_target: nil, depth: nil, risks: [], erosion_cache: %{}
end

defmodule Advent2018.Day22 do
  alias Advent2018.Day22.Survey

  def part_a(depth, {x_target, y_target}) do
    survey = initialize(depth, {x_target, y_target})

    Enum.reduce(0..y_target, survey, fn y, acc ->
      Enum.reduce(0..x_target, acc, fn x, acc ->
        add_risk(acc, {x, y})
      end)
    end)
    |> risk_total
  end

  defp add_risk(survey, coord) do
    survey
    |> cache_erosion(coord)
    |> remember_risk(coord)
  end

  defp remember_risk(survey, coord) do
    new_risk = risk(survey, coord)
    %{survey | risks: [new_risk | survey.risks]}
  end

  defp cache_erosion(%Survey{erosion_cache: cache} = survey, coord) do
    new_cache =
      Map.put_new_lazy(cache, coord, fn ->
        (geologic_index(survey, coord) + survey.depth)
        |> Integer.mod(20183)
      end)

    %{survey | erosion_cache: new_cache}
  end

  defp risk(survey, coord) do
    erosion_level(survey, coord)
    |> Integer.mod(3)
  end

  defp geologic_index(_survey, {0, 0}), do: 0
  defp geologic_index(%Survey{x_target: x, y_target: y}, {x, y}), do: 0

  defp geologic_index(_survey, {x, 0}) do
    x * 16807
  end

  defp geologic_index(_survey, {0, y}) do
    y * 48271
  end

  defp geologic_index(survey, {x, y}) do
    erosion_level(survey, {x - 1, y}) * erosion_level(survey, {x, y - 1})
  end

  defp erosion_level(%Survey{erosion_cache: cache}, coord) do
    Map.get(cache, coord)
  end

  defp initialize(depth, {x_target, y_target}) do
    %Survey{depth: depth, x_target: x_target, y_target: y_target}
  end

  defp risk_total(%Survey{risks: risks}) do
    Enum.sum(risks)
  end
end
