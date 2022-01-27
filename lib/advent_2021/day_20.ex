defmodule Advent2021.Day20 do
  def pixel_count(input) do
    {algorithm, image} = parse(input)
    original_bounds = bounds(image)

    image
    |> add_padding
    |> enhance(algorithm)
    |> enhance(algorithm)
    |> Enum.count(fn {xy, pixel} ->
      pixel == 1 && in_expanded_bounds(xy, original_bounds)
    end)
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

  defp in_expanded_bounds({x, y}, bounds) do
    {min_x, max_x, min_y, max_y} = bounds
    border = 2

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

  defp parse(input) do
    [first_line | rest] = String.split(input)
    {map_algorithm(first_line), map_image(rest)}
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

  defp add_padding(image) do
    {min_x, max_x, min_y, max_y} = bounds(image)
    border = 10

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
