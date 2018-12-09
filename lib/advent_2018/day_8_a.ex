defmodule Advent2018.Day8A do
  def metadata_sum(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> metadata_sum([])
  end

  defp metadata_sum([0, meta_count | tail], acc) do
    metadata_sum(Enum.drop(tail, meta_count), Enum.take(tail, meta_count) ++ acc)
  end

  defp metadata_sum([_child_count, meta_count | tail], acc) do
    metadata_sum(Enum.drop(tail, -meta_count), Enum.take(tail, -meta_count) ++ acc)
  end

  defp metadata_sum([], acc) do
    Enum.sum(acc)
  end
end
