defmodule Advent2018.Day6 do
  def largest_finite_area(input) do
    distances = distances(input)
    infinite_coordinates = infinite_coordinates(distances, input)

    Enum.group_by(distances, fn {_, {coordinate, _}} -> coordinate end)
    |> Enum.map(fn {coordinate, values} -> {coordinate, Enum.count(values)} end)
    |> reject_infinite(infinite_coordinates)
    |> Enum.max_by(fn {_, value} -> value end)
    |> elem(1)
  end

  def edges(input) do
    coordinates = as_coordinates(input)

    {{_, top}, {_, bottom}} = Enum.min_max_by(coordinates, fn {_, y} -> y end)
    {{left, _}, {right, _}} = Enum.min_max_by(coordinates, fn {x, _} -> x end)

    {top, bottom, left, right}
  end

  def board(input) do
    {top, bottom, left, right} = edges(input)

    for x <- left..right,
        y <- top..bottom do
      {x, y}
    end
  end

  def perimeter(input) do
    {top, bottom, left, right} = edges(input)

    board(input)
    |> Enum.filter(fn {x, y} ->
      x == right || x == left || y == top || y == bottom
    end)
  end

  def distances(input) do
    coordinates = as_coordinates(input)
    positions = board(input)

    Enum.reduce(coordinates, %{}, fn coordinate, acc ->
      Enum.reduce(positions, acc, fn position, acc ->
        new_distance = distance(position, coordinate)

        Map.update(acc, position, {coordinate, new_distance}, fn {existing_coordinate, distance} ->
          updated_value(distance, new_distance, coordinate, existing_coordinate)
        end)
      end)
    end)
  end

  defp infinite_coordinates(distances, input) do
    perimeter = perimeter(input)

    Enum.filter(distances, fn {position, _} -> position in perimeter end)
    |> Enum.map(fn {_, {coordinate, _}} -> coordinate end)
    |> MapSet.new()
    |> Enum.to_list()
  end

  defp reject_infinite(coordinate_areas, infinite_coordinates) do
    Enum.reject(coordinate_areas, fn {coordinate, _} ->
      coordinate in infinite_coordinates
    end)
  end

  defp updated_value(same_distance, same_distance, _coordinate, _existing_coordinate) do
    {nil, same_distance}
  end

  defp updated_value(distance, new_distance, coordinate, _existing_coordinate) when new_distance < distance do
    {coordinate, new_distance}
  end

  defp updated_value(distance, _new_distance, _coordinate, existing_coordinate) do
    {existing_coordinate, distance}
  end

  defp distance({position_x, position_y}, {coordinate_x, coordinate_y}) do
    abs(position_x - coordinate_x) + abs(position_y - coordinate_y)
  end

  defp as_coordinates(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&line_to_coordinate/1)
  end

  defp line_to_coordinate(line) do
    [x, y] = String.split(line, ", ")
    {String.to_integer(x), String.to_integer(y)}
  end
end
