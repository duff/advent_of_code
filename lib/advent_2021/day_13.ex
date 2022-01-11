defmodule Advent2021.Day13 do
  def dot_count_after_first_fold(input) do
    dots = dots(input)
    folds = folds(input)

    perform_fold(dots, List.first(folds))
    |> Enum.count()
  end

  def dot_count_after_all_folds(input) do
    dots = dots(input)
    folds = folds(input)

    folds
    |> Enum.reduce(dots, fn fold, acc -> perform_fold(acc, fold) end)
    # |> print
    |> Enum.count()
  end

  defp perform_fold(dots, {"y", coordinate}) do
    {above_fold, below_fold} = Enum.split_with(dots, fn {_x, y} -> y < coordinate end)

    above_fold
    |> MapSet.new()
    |> MapSet.union(fold_up(below_fold, coordinate))
  end

  defp perform_fold(dots, {"x", coordinate}) do
    {left_of_fold, right_of_fold} = Enum.split_with(dots, fn {x, _y} -> x < coordinate end)

    left_of_fold
    |> MapSet.new()
    |> MapSet.union(fold_left(right_of_fold, coordinate))
  end

  defp fold_up(below_fold, coordinate) do
    below_fold
    |> Enum.map(fn {x, y} -> {x, y - (y - coordinate) * 2} end)
    |> MapSet.new()
  end

  defp fold_left(right_of_fold, coordinate) do
    right_of_fold
    |> Enum.map(fn {x, y} -> {x - (x - coordinate) * 2, y} end)
    |> MapSet.new()
  end

  defp dots(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(MapSet.new(), &dot/2)
  end

  defp folds(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], &fold/2)
    |> Enum.reverse()
  end

  defp dot("fold" <> _, acc) do
    acc
  end

  defp dot(line, acc) do
    [x, y] = String.split(line, ",")
    MapSet.put(acc, {String.to_integer(x), String.to_integer(y)})
  end

  defp fold("fold along " <> rest, acc) do
    [x_or_y, number] = String.split(rest, "=")
    [{x_or_y, String.to_integer(number)} | acc]
  end

  defp fold(_line, acc) do
    acc
  end

  # defp print(dots) do
  #   IO.puts("")
  #   IO.puts("")

  #   for y <- 0..10 do
  #     IO.puts(
  #       Enum.map(0..40, fn x ->
  #         if MapSet.member?(dots, {x, y}) do
  #           " O "
  #         else
  #           "   "
  #         end
  #       end)
  #     )
  #   end
  # end
end
