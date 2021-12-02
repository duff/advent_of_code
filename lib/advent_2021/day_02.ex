defmodule Advent2021.Day02 do
  def horizontal_depth_product(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([0, 0], &move/2)
    |> Enum.product()
  end

  def horizontal_depth_product_with_aim(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([0, 0, 0], &move_with_aim/2)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp move("forward " <> amount, [horizontal, depth]) do
    [horizontal + String.to_integer(amount), depth]
  end

  defp move("down " <> amount, [horizontal, depth]) do
    [horizontal, depth + String.to_integer(amount)]
  end

  defp move("up " <> amount, [horizontal, depth]) do
    [horizontal, depth - String.to_integer(amount)]
  end

  defp move_with_aim("forward " <> amount, [horizontal, depth, aim]) do
    value = String.to_integer(amount)
    [horizontal + value, depth + aim * value, aim]
  end

  defp move_with_aim("down " <> amount, [horizontal, depth, aim]) do
    [horizontal, depth, aim + String.to_integer(amount)]
  end

  defp move_with_aim("up " <> amount, [horizontal, depth, aim]) do
    [horizontal, depth, aim - String.to_integer(amount)]
  end
end
