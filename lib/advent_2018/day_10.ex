defmodule Advent2018.Day10.Position do
  defstruct [:x, :y, :velocity_x, :velocity_y]
end

defmodule Advent2018.Day10.Rectangle do
  defstruct [:top_left, :bottom_right]
  alias Advent2018.Day10.Rectangle

  def area(%Rectangle{top_left: {x1, y1}, bottom_right: {x2, y2}}) do
    abs((x1 - x2) * (y1 - y2))
  end
end

defmodule Advent2018.Day10 do
  alias Advent2018.Day10.{Position, Rectangle}

  def print_eventual_message(input) do
    positions = to_positions(input)
    {positions, _, _} = smallest_sky(positions)
    draw(positions)
  end

  def seconds_to_wait_for_message(input) do
    positions = to_positions(input)
    {_, _, seconds} = smallest_sky(positions)
    seconds
  end

  def to_positions(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def move(%Position{x: x, y: y, velocity_x: velocity_x, velocity_y: velocity_y} = position) do
    %{position | x: x + velocity_x, y: y + velocity_y}
  end

  def bounding_rectangle(positions) do
    {min_x, max_x} = Enum.min_max_by(positions, fn %Position{x: x} -> x end)
    {min_y, max_y} = Enum.min_max_by(positions, fn %Position{y: y} -> y end)
    %Rectangle{top_left: {min_x.x - 1, min_y.y - 1}, bottom_right: {max_x.x + 1, max_y.y + 1}}
  end

  def area(positions) do
    positions
    |> bounding_rectangle()
    |> Rectangle.area()
  end

  def smallest_sky(positions) do
    Enum.reduce(1..11_000, [{positions, area(positions), 0}], fn each_second, [{previous_positions, _, _} | _] = acc ->
      next_positions = Enum.map(previous_positions, &move/1)
      next_area = area(next_positions)
      [{next_positions, next_area, each_second} | acc]
    end)
    |> Enum.min_by(fn {_, area, _} -> area end)
  end

  def draw(positions) do
    %Rectangle{top_left: {x1, y1}, bottom_right: {x2, y2}} = bounding_rectangle(positions)

    rows =
      for y <- y1..y2 do
        row(x1, x2, y, positions)
      end
      |> Enum.join("\n")

    IO.puts(rows)
  end

  defp row(x1, x2, y, positions) do
    for x <- x1..x2, into: "" do
      if includes(positions, x, y) do
        "*"
      else
        " "
      end
    end
  end

  defp includes(positions, x, y) do
    Enum.any?(positions, fn each ->
      each.x == x && each.y == y
    end)
  end

  defp parse_line(line) do
    [x, y, velocity_x, velocity_y] = retrieve_ints(line)
    %Position{x: x, y: y, velocity_x: velocity_x, velocity_y: velocity_y}
  end

  defp retrieve_ints(line) do
    Regex.run(position_regex(), line, capture: :all_but_first)
    |> Enum.map(fn each -> String.trim(each) |> String.to_integer() end)
  end

  defp position_regex do
    ~r/position=<([- ]*\d*),([- ]*\d*)> velocity=<([- ]*\d*),([- ]*\d*)>/
  end
end
