defmodule Advent2018.Day17.Scan do
  defstruct clay: MapSet.new(),
            water: MapSet.new(),
            min_x: nil,
            max_x: nil,
            min_y: nil,
            max_y: nil,
            hit_left_clay: false,
            hit_right_clay: false
end

defmodule Advent2018.Day17 do
  alias Advent2018.Day17.Scan

  def part_a(input) do
    %Scan{}
    |> initialize(input)
    |> print
    |> flow
    |> print
    |> water_count
  end

  defp flow(scan) do
    scan
    |> add_water_vertically(500, 1)
  end

  defp add_water_vertically(%Scan{max_y: max_y} = scan, _x, max_y) do
    scan
  end

  defp add_water_vertically(%Scan{clay: clay, water: water} = scan, x, y) do
    if MapSet.member?(clay, {x, y}) || MapSet.member?(water, {x, y}) do
      # IO.inspect({x, y}, label: "HIT CLAY OR WATER")

      scan =
        scan
        |> add_water_left(x - 1, y - 1)
        |> add_water_right(x + 1, y - 1)

      if scan.hit_left_clay && scan.hit_right_clay do
        scan
        |> add_water_vertically(x, y - 1)
      else
        scan
      end
    else
      %{scan | water: MapSet.put(water, {x, y})}
      |> add_water_vertically(x, y + 1)
    end
  end

  defp add_water_left(%Scan{clay: clay, water: water} = scan, x, y) do
    if MapSet.member?(clay, {x, y}) do
      # IO.inspect({x, y}, label: "HIT CLAY LEFT")
      %{scan | hit_left_clay: true}
    else
      if water_or_clay_below(scan, x, y) do
        %{scan | water: MapSet.put(water, {x, y}), hit_left_clay: false}
        |> add_water_left(x - 1, y)
      else
        %{scan | water: MapSet.put(water, {x, y}), hit_left_clay: false}
        |> add_water_vertically(x, y + 1)
      end
    end
  end

  defp add_water_right(%Scan{clay: clay, water: water} = scan, x, y) do
    if MapSet.member?(clay, {x, y}) do
      # IO.inspect({x, y}, label: "HIT CLAY RIGHT")
      %{scan | hit_right_clay: true}
    else
      if water_or_clay_below(scan, x, y) do
        %{scan | water: MapSet.put(water, {x, y}), hit_right_clay: false}
        |> add_water_right(x + 1, y)
      else
        %{scan | water: MapSet.put(water, {x, y}), hit_right_clay: false}
        |> add_water_vertically(x, y + 1)
      end
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

  defp print(scan) do
    IO.puts("")

    scan
    |> display_string
    |> IO.puts()

    IO.puts("")

    scan
  end

  defp display_string(%Scan{min_y: min_y, max_y: max_y} = scan) do
    Enum.reduce((min_y - 1)..max_y, [], fn y, rows ->
      rows ++ [row_string(scan, y)]
    end)
    |> Enum.join("\n")
  end

  defp row_string(%Scan{min_x: min_x, max_x: max_x} = scan, y) do
    Enum.reduce(min_x..max_x, "", fn x, row ->
      row <> display_character(scan, x, y)
    end)
  end

  defp display_character(_, 500, 0), do: "+"

  defp display_character(%Scan{clay: clay, water: water}, x, y) do
    cond do
      MapSet.member?(clay, {x, y}) -> "#"
      MapSet.member?(water, {x, y}) -> "~"
      true -> "."
    end
  end
end
