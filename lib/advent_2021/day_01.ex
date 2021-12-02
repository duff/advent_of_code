defmodule Advent2021.Day01 do
  def increases(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> right > left end)
  end

  def sliding_window_increases(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn each -> Enum.sum(each) end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> right > left end)
  end
end
