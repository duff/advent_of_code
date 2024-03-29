defmodule Advent2021.Day18 do
  def part_one(input) do
    input
    |> add_and_reduce
    |> magnitude
  end

  def part_two(input) do
    input
    |> String.split()
    |> Enum.map(&parse/1)
    |> permutations
    |> Enum.map(fn {left, right} ->
      left
      |> add(right)
      |> explode_split()
      |> magnitude
    end)
    |> Enum.max()
  end

  def add_and_reduce(input) do
    input
    |> String.split()
    |> Enum.map(&parse/1)
    |> Enum.reduce(fn each, acc ->
      acc
      |> add(each)
      |> explode_split()
    end)
  end

  def parse(input) do
    input
    |> String.replace("[", "{")
    |> String.replace("]", "}")
    |> Code.string_to_quoted!()
  end

  def explode_split(ast) do
    case explode(ast) do
      {true, exploded} ->
        explode_split(exploded)

      {false, not_exploded} ->
        case split(not_exploded) do
          {true, split} ->
            explode_split(split)

          {false, not_split} ->
            not_split
        end
    end
  end

  def add(one, two) do
    {one, two}
  end

  def magnitude({left, right}) do
    magnitude(left) * 3 + magnitude(right) * 2
  end

  def magnitude(value) do
    value
  end

  def split({left, right}) do
    case split(left) do
      {false, left} ->
        case split(right) do
          {false, right} ->
            {false, {left, right}}

          {true, right} ->
            {true, {left, right}}
        end

      {true, left} ->
        {true, {left, right}}
    end
  end

  def split(val) when is_integer(val) and val > 9 do
    {true, {div(val, 2), ceil(val / 2)}}
  end

  def split(val), do: {false, val}

  def explode(ast) do
    list = as_list(ast)
    index_left = find_explosive(list)

    if index_left do
      {true, actually_explode(list, index_left)}
    else
      {false, ast}
    end
  end

  defp permutations(lines) do
    max = length(lines)

    for x <- 0..(max - 1),
        y <- 0..(max - 1),
        y != x do
      {Enum.at(lines, x), Enum.at(lines, y)}
    end
  end

  defp actually_explode(list, index_left) do
    index_right = index_left + 2

    list
    |> splode_right(index_right)
    |> splode_left(index_left)
    |> replace_exploding_pair_with_zero(index_left, index_right)
    |> Enum.join()
    |> Code.string_to_quoted!()
  end

  defp splode_right(list, index_right) do
    index_next_number =
      list
      |> Enum.with_index()
      |> Enum.find_index(fn {element, index} -> index > index_right and is_integer(element) end)

    if index_next_number do
      List.update_at(list, index_next_number, fn existing -> existing + Enum.at(list, index_right) end)
    else
      list
    end
  end

  defp splode_left(list, index_left) do
    found =
      list
      |> Enum.with_index()
      |> Enum.slice(0..(index_left - 1))
      |> Enum.reverse()
      |> Enum.find(fn {element, _index} -> is_integer(element) end)

    case found do
      {_element, index} -> List.update_at(list, index, fn existing -> existing + Enum.at(list, index_left) end)
      nil -> list
    end
  end

  defp find_explosive(list), do: find_explosive(list, 0, 0)
  defp find_explosive(["{" | rest], index, depth), do: find_explosive(rest, index + 1, depth + 1)
  defp find_explosive(["}" | rest], index, depth), do: find_explosive(rest, index + 1, depth - 1)
  defp find_explosive([left, ",", right, "}" | _], index, 5) when is_integer(left) and is_integer(right), do: index
  defp find_explosive([_ | rest], index, depth), do: find_explosive(rest, index + 1, depth)
  defp find_explosive([], _index, _depth), do: false

  defp replace_exploding_pair_with_zero(list, index_left, index_right) do
    (Enum.slice(list, 0..(index_left - 2)) ++ Enum.slice(list, (index_right + 2)..length(list)))
    |> List.insert_at(index_left - 1, 0)
  end

  defp as_list(ast) do
    ast
    |> Macro.to_string()
    |> String.replace(" ", "")
    |> String.graphemes()
    |> Enum.map(&str_or_int/1)
    |> combine_adjacent_numbers()
  end

  defp combine_adjacent_numbers(list), do: combine_adjacent_numbers(list, [])
  defp combine_adjacent_numbers([], result), do: result |> Enum.reverse()

  defp combine_adjacent_numbers([element | rest], [last | rest_result]) when is_integer(element) and is_integer(last) do
    combine_adjacent_numbers(rest, [Integer.undigits([last, element]) | rest_result])
  end

  defp combine_adjacent_numbers([element | rest], result), do: combine_adjacent_numbers(rest, [element | result])

  defp str_or_int(val) do
    case Integer.parse(val) do
      :error -> val
      {number, _rem} -> number
    end
  end
end
