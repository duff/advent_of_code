defmodule Advent2018.Day17.Scan do
  defstruct clay: MapSet.new(),
            water: MapSet.new(),
            min_x: nil,
            max_x: nil,
            min_y: nil,
            max_y: nil,
            iterations: 0
end

defmodule Advent2018.Day17 do
  alias Advent2018.Day17.Scan

  def part_a(input) do
    %Scan{}
    |> initialize(input)
    # |> IO.inspect(limit: 10000)
    # |> print
    |> flow(500, 1)
    # |> IO.inspect(limit: 10000)
    |> print
    |> water_count
  end

  defp flow(%Scan{iterations: 9100} = scan, _x, _y) do
    scan
  end

  defp flow(%Scan{max_y: max_y} = scan, _x, y) when max_y == y - 1 do
    scan
  end

  defp flow(%Scan{water: water} = scan, x, y) do
    # print(scan)
    cond do
      clay_below?(scan, x, y) ->
        spread(scan, x, y)

      # water_below?(scan, x, y) ->
      #   %{scan | water: MapSet.put(water, {x, y}), iterations: scan.iterations + 1}
      #   |> spread(x, y - 1)

      # water?(scan, x, y) ->
      #   # spread(scan, x, y - 1)
      #   scan

      true ->
        %{scan | water: MapSet.put(water, {x, y}), iterations: scan.iterations + 1}
        |> flow(x, y + 1)
    end
  end

  defp spread(scan, x, y) do
    # print(scan)
    if in_bucket?(scan, x, y) do
      scan
      |> fill_row(x, y)
      |> spread(x, y - 1)
    else
      cond do
        clay_wall_to_the_left?(scan, x, y) ->
          scan
          |> fill_from_left_clay(x, y)
          |> fill_to_right_dropoff(x, y)
          |> flow(first_dropoff_to_the_right(scan, x, y), y + 1)

        clay_wall_to_the_right?(scan, x, y) ->
          scan
          |> fill_from_right_clay(x, y)
          |> fill_to_left_dropoff(x, y)
          |> flow(first_dropoff_to_the_left(scan, x, y), y + 1)

        true ->
          right = first_dropoff_to_the_right(scan, x, y)
          left = first_dropoff_to_the_left(scan, x, y)

          scan
          |> fill_from(x, right, y)
          |> fill_from(x, left, y)
          |> flow(left, y + 1)
          |> flow(right, y + 1)
      end
    end
  end

  defp fill_to_right_dropoff(scan, x, y) do
    to = first_dropoff_to_the_right(scan, x, y)
    fill_from(scan, x, to, y)
  end

  defp fill_to_left_dropoff(scan, x, y) do
    to = first_dropoff_to_the_left(scan, x, y)
    fill_from(scan, x, to, y)
  end

  defp first_dropoff_to_the_right(scan, x, y) do
    Enum.find((x + 1)..scan.max_x, fn each ->
      clay_below?(scan, each, y) && (open_space_below?(scan, each + 1, y) || water_below?(scan, each + 1, y))
    end) + 1
  end

  defp first_dropoff_to_the_left(scan, x, y) do
    Enum.find((x - 1)..scan.min_x, fn each ->
      clay_below?(scan, each, y) && (open_space_below?(scan, each - 1, y) || water_below?(scan, each - 1, y))
    end) - 1
  end

  defp fill_from_left_clay(scan, x, y) do
    from = first_clay_to_the_left(scan, x, y) + 1
    fill_from(scan, from, x, y)
  end

  defp fill_from_right_clay(scan, x, y) do
    from = first_clay_to_the_right(scan, x, y) - 1
    fill_from(scan, from, x, y)
  end

  defp fill_from(%Scan{water: water} = scan, from_x, to_x, y) do
    new_water =
      Enum.reduce(from_x..to_x, water, fn each, acc ->
        MapSet.put(acc, {each, y})
      end)

    %{scan | water: new_water, iterations: scan.iterations + 1}
  end

  defp fill_row(%Scan{water: water} = scan, x, y) do
    from = first_clay_to_the_left(scan, x, y) + 1
    to = first_clay_to_the_right(scan, x, y) - 1

    new_water =
      Enum.reduce(from..to, water, fn each, acc ->
        MapSet.put(acc, {each, y})
      end)

    %{scan | water: new_water, iterations: scan.iterations + 1}
  end

  defp first_clay_to_the_left(scan, x, y) do
    Enum.find((x - 1)..scan.min_x, fn each ->
      clay?(scan, each, y)
    end)
  end

  defp first_clay_to_the_right(scan, x, y) do
    Enum.find((x + 1)..scan.max_x, fn each ->
      clay?(scan, each, y)
    end)
  end

  defp in_bucket?(scan, x, y) do
    clay_wall_to_the_left?(scan, x, y) && clay_wall_to_the_right?(scan, x, y)
  end

  defp clay_wall_to_the_left?(scan, x, y) do
    Enum.reduce_while((x - 1)..scan.min_x, false, fn each, acc ->
      cond do
        open_space_below?(scan, each, y) ->
          {:halt, false}

        clay?(scan, each, y) ->
          {:halt, true}

        true ->
          {:cont, false}
      end
    end)
  end

  defp clay_wall_to_the_right?(scan, x, y) do
    Enum.reduce_while((x + 1)..scan.max_x, false, fn each, acc ->
      cond do
        open_space_below?(scan, each, y) ->
          {:halt, false}

        clay?(scan, each, y) ->
          {:halt, true}

        true ->
          {:cont, false}
      end
    end)
  end

  defp open_space_below?(scan, x, y) do
    !clay_below?(scan, x, y) && !water_below?(scan, x, y)
  end

  defp clay?(%Scan{clay: clay}, x, y) do
    MapSet.member?(clay, {x, y})
  end

  defp water?(%Scan{water: water}, x, y) do
    MapSet.member?(water, {x, y})
  end

  defp clay_below?(%Scan{clay: clay}, x, y) do
    MapSet.member?(clay, {x, y + 1})
  end

  defp water_below?(%Scan{water: water}, x, y) do
    MapSet.member?(water, {x, y + 1})
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

    %{scan | min_y: min_y, max_y: max_y, min_x: min_x - 1, max_x: max_x + 1}
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
    Enum.each((scan.min_y - 1)..scan.max_y, fn y ->
      Enum.each((scan.min_x - 1)..(scan.max_x + 1), fn x ->
        IO.write(cell(scan, x, y))
      end)

      IO.write("\n")
    end)

    IO.write("\n")

    scan
  end

  defp cell(_, 500, 0), do: "+"

  defp cell(scan, x, y) do
    cond do
      water?(scan, x, y) && clay?(scan, x, y) -> "?"
      water?(scan, x, y) -> "~"
      clay?(scan, x, y) -> "#"
      true -> "."
    end
  end
end
