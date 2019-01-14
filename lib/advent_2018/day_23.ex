defmodule Advent2018.Day23.Nanobot do
  defstruct ~w(x y z radius)a
end

defmodule Advent2018.Day23 do
  alias Advent2018.Day23.Nanobot

  def part_a(input) do
    nanobots = input |> parse
    strongest = Enum.max_by(nanobots, fn each -> each.radius end)
    Enum.count(nanobots, fn each -> in_range?(strongest, each) end)
  end

  defp in_range?(%Nanobot{radius: radius} = strongest, nanobot) do
    distance(strongest, nanobot) <= radius
  end

  defp distance(%Nanobot{x: x1, y: y1, z: z1}, %Nanobot{x: x2, y: y2, z: z2}) do
    abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&nanobot/1)
  end

  defp nanobot(string) do
    map =
      Regex.named_captures(nanobot_regex(), string)
      |> Enum.map(fn {key, value} -> {String.to_atom(key), String.to_integer(value)} end)

    struct!(Nanobot, map)
  end

  defp nanobot_regex do
    ~r/pos=<(?<x>-?\d*),(?<y>-?\d*),(?<z>-?\d*)>, r=(?<radius>-?\d*)/
  end
end
