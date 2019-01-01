defmodule Advent2018.Day17.Scan do
  defstruct clay: MapSet.new(),
            water: MapSet.new(),
            min_x: nil,
            max_x: nil,
            min_y: nil,
            max_y: nil,
            hit_left_clay: false,
            hit_right_clay: false,
            iterations: 0
end

defmodule Advent2018.Day17 do
  alias Advent2018.Day17.Scan

  def part_a(input) do
    %Scan{}
    |> initialize(input)
    # |> print
    |> flow(500, 1)
    |> print
    |> water_count
  end

  defp flow(%Scan{iterations: 100_000} = scan, _x, _y) do
    scan
  end

  defp flow(%Scan{max_y: max_y} = scan, _x, max_y) do
    scan
  end

  defp flow(%Scan{clay: clay, water: water} = scan, x, y) do
    cond do
      MapSet.member?(clay, {x, y}) ->
        scan
        |> add_water_left_and_right(x, y - 1)

      MapSet.member?(water, {x, y}) ->
        scan
        |> add_water_left_and_right(x, y)

      true ->
        %{scan | water: MapSet.put(water, {x, y}), iterations: scan.iterations + 1}
        |> flow(x, y + 1)
    end
  end

  defp add_water_left(%Scan{clay: clay, water: water} = scan, x, y) do
    if MapSet.member?(clay, {x, y}) do
      %{scan | hit_left_clay: y}
    else
      if water_or_clay_below(scan, x, y) do
        if MapSet.member?(water, {x, y}) do
          scan
        else
          %{scan | water: MapSet.put(water, {x, y}), hit_left_clay: false}
          |> add_water_left(x - 1, y)
        end
      else
        %{scan | water: MapSet.put(water, {x, y}), hit_left_clay: false}
        |> flow(x, y + 1)
      end
    end
  end

  defp add_water_right(%Scan{clay: clay, water: water} = scan, x, y) do
    if MapSet.member?(clay, {x, y}) do
      %{scan | hit_right_clay: y}
    else
      if water_or_clay_below(scan, x, y) do
        if MapSet.member?(water, {x, y}) do
          scan
        else
          %{scan | water: MapSet.put(water, {x, y}), hit_right_clay: false}
          |> add_water_right(x + 1, y)
        end
      else
        %{scan | water: MapSet.put(water, {x, y}), hit_right_clay: false}
        |> flow(x, y + 1)
      end
    end
  end

  defp add_water_left_and_right(%Scan{} = scan, x, y) do
    scan =
      scan
      |> add_water_left(x - 1, y)
      |> add_water_right(x + 1, y)

    if scan.hit_left_clay == y && scan.hit_right_clay == y do
      scan
      |> flow(x, y - 1)
    else
      scan
    end
  end

  defp water_or_clay_below(%Scan{clay: clay, water: water}, x, y) do
    MapSet.member?(clay, {x, y + 1}) || MapSet.member?(water, {x, y + 1})
  end

  defp initialize(scan, input) do
    lines = String.split(input, "\n", trim: true)
    clay = Enum.reduce(lines, scan.clay, &line_to_clay/2)

    %{scan | clay: clay}
    |> add_min_max_y
  end

  defp line_to_clay(line, clay) do
    Regex.run(line_regex(), line, capture: :all_but_first)
    |> all_ints
    |> line_parts_to_clay(clay)
  end

  defp line_parts_to_clay(["x", x, "y", from_y, to_y], clay) do
    for y <- from_y..to_y, into: clay do
      {x, y}
    end
  end

  defp line_parts_to_clay(["y", y, "x", from_x, to_x], clay) do
    for x <- from_x..to_x, into: clay do
      {x, y}
    end
  end

  defp add_min_max_y(scan) do
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(scan.clay, fn {_x, y} -> y end)
    {{min_x, _}, {max_x, _}} = Enum.min_max_by(scan.clay, fn {x, _y} -> x end)

    %{scan | min_y: min_y, max_y: max_y + 1, min_x: min_x, max_x: max_x}
  end

  defp all_ints([x_or_y, num_1, y_or_x, num_2, num_3]) do
    [x_or_y, String.to_integer(num_1), y_or_x, String.to_integer(num_2), String.to_integer(num_3)]
  end

  defp line_regex do
    ~r/([xy])=(\d+), ([xy])=(\d+)..(\d+)/
  end

  defp water_count(scan) do
    MapSet.size(scan.water)
  end

  def print(scan) do
    Enum.each(scan.min_y..scan.max_y, fn y ->
      Enum.each((scan.min_x - 1)..(scan.max_x + 1), fn x ->
        IO.write(cell(scan, x, y))
      end)

      IO.write("\n")
    end)

    IO.write("\n")
    scan
  end

  defp cell(_, 500, 0), do: "+"

  defp cell(%Scan{clay: clay, water: water}, x, y) do
    cond do
      MapSet.member?(clay, {x, y}) -> "#"
      MapSet.member?(water, {x, y}) -> "~"
      true -> "."
    end
  end
end
