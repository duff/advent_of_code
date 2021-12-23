defmodule Advent2021.Day05.Segment do
  alias Advent2021.Day05.Segment

  @enforce_keys [:x1, :y1, :x2, :y2]
  defstruct [:x1, :y1, :x2, :y2]

  def new(input) do
    [first, _, last] = String.split(input)

    [x1, y1] = split_map(first)
    [x2, y2] = split_map(last)
    %Segment{x1: x1, y1: y1, x2: x2, y2: y2}
  end

  def points(%Segment{x1: same_x, y1: y1, x2: same_x, y2: y2}), do: for(y <- y1..y2, do: {same_x, y})
  def points(%Segment{x1: x1, y1: same_y, x2: x2, y2: same_y}), do: for(x <- x1..x2, do: {x, same_y})
  def points(_), do: []

  defp split_map(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule Advent2021.Day05 do
  alias Advent2021.Day05.Segment

  def overlapping_point_count(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&Segment.new/1)
    |> Enum.map(&Segment.points/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, count} -> count > 1 end)
    |> Enum.count()
  end
end
