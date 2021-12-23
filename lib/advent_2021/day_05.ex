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

  def hv_points(%Segment{x1: same_x, y1: y1, x2: same_x, y2: y2}), do: for(y <- y1..y2, do: {same_x, y})
  def hv_points(%Segment{x1: x1, y1: same_y, x2: x2, y2: same_y}), do: for(x <- x1..x2, do: {x, same_y})
  def hv_points(_), do: []

  def diagonal_points(%Segment{x1: same, y1: _, x2: same, y2: _}), do: []

  def diagonal_points(%Segment{x1: x1, y1: y1, x2: x2, y2: y2}) when abs((y2 - y1) / (x2 - x1)) == 1 do
    for x <- x1..x2,
        y <- y1..y2,
        x - x1 != 0,
        abs((y - y1) / (x - x1)) == 1 do
      {x, y}
    end
    |> Enum.concat([{x1, y1}])
  end

  def diagonal_points(_), do: []

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
    |> segments()
    |> Enum.map(&Segment.hv_points/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, count} -> count > 1 end)
    |> Enum.count()
  end

  def overlapping_point_count_with_diagonals(input) do
    input
    |> segments()
    |> all_points
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, count} -> count > 1 end)
    |> Enum.count()
  end

  defp all_points(segments) do
    Enum.map(segments, &Segment.hv_points/1) ++ Enum.map(segments, &Segment.diagonal_points/1)
  end

  defp segments(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&Segment.new/1)
  end
end
