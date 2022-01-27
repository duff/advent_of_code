defmodule Advent2021.Day20 do
  def part_one(input) do
    pixel_count(input, 2)
  end

  def part_two(input) do
    pixel_count(input, 50)
  end

  def pixel_count(input, runs) do
    {algorithm, image, original_bounds} = parse(input, runs)

    1..runs
    |> Enum.reduce(image, fn _, acc -> enhance(acc, algorithm) end)
    |> Enum.count(fn {xy, pixel} -> lit_pixel(pixel, xy, original_bounds, runs) end)
  end

  defp enhance(image, algorithm) do
    enhance(Map.keys(image), image, algorithm, Map.new())
  end

  defp enhance([key | rest], image, algorithm, result) do
    enhance(rest, image, algorithm, Map.put(result, key, Map.fetch!(algorithm, surrounding_binary(key, image))))
  end

  defp enhance([], _image, _algorithm, result), do: result

  defp surrounding_binary(xy, image) do
    xy
    |> coordinates()
    |> Enum.map(fn each -> Map.get(image, each, 0) end)
    |> Integer.undigits(2)
  end

  defp lit_pixel(pixel, xy, bounds, runs) do
    pixel == 1 && in_expanded_bounds(xy, bounds, runs)
  end

  defp in_expanded_bounds({x, y}, bounds, runs) do
    {min_x, max_x, min_y, max_y} = bounds
    border = runs

    x >= min_x - border && x <= max_x + border && y >= min_y - border && y <= max_y + border
  end

  defp coordinates({x, y}) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
  end

  defp parse(input, runs) do
    [first_line | rest] = String.split(input)
    image = map_image(rest)
    original_bounds = bounds(image)

    {map_algorithm(first_line), add_padding(image, runs), original_bounds}
  end

  defp map_algorithm(str) do
    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Map.new(fn {pixel, index} -> {index, pixel_to_integer(pixel)} end)
  end

  defp map_image(strings) do
    rows = Enum.map(strings, &String.graphemes/1)

    for {row, x} <- Enum.with_index(rows),
        {pixel, y} <- Enum.with_index(row),
        into: %{} do
      {{x, y}, pixel_to_integer(pixel)}
    end
  end

  defp add_padding(image, runs) do
    {min_x, max_x, min_y, max_y} = bounds(image)
    border = 2 * runs

    coords =
      for x <- (min_x - border)..(max_x + border),
          y <- (min_y - border)..(max_y + border) do
        {x, y}
      end

    Enum.reduce(coords, image, fn each, acc ->
      Map.put_new(acc, each, 0)
    end)
  end

  defp pixel_to_integer("."), do: 0
  defp pixel_to_integer("#"), do: 1

  defp bounds(image) do
    {{min_x, _}, _} = Enum.min_by(image, fn {{x, _}, _} -> x end)
    {{_, min_y}, _} = Enum.min_by(image, fn {{_, y}, _} -> y end)

    {{max_x, _}, _} = Enum.max_by(image, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(image, fn {{_, y}, _} -> y end)

    {min_x, max_x, min_y, max_y}
  end

  # defp print(image) do
  #   {min_x, max_x, min_y, max_y} = bounds(image)

  #   IO.puts("")

  #   for x <- min_x..max_x do
  #     for y <- min_y..max_y do
  #       value = Map.get(image, {x, y})
  #       IO.write(String.pad_leading(Integer.to_string(value), 2))
  #     end

  #     IO.write("\n")
  #   end

  #   IO.puts("")
  #   image
  # end
end
