defmodule Advent2021.Day03 do
  def power_consumption(input) do
    f = frequencies(input)
    gamma_rate(f) * epsilon_rate(f)
  end

  defp frequencies(input) do
    input
    |> String.split()
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
  end

  defp gamma_rate(list) do
    list
    |> Enum.map(fn each -> Enum.max_by(each, fn {_key, value} -> value end) end)
    |> keys_to_int()
  end

  defp epsilon_rate(list) do
    list
    |> Enum.map(fn each -> Enum.min_by(each, fn {_key, value} -> value end) end)
    |> keys_to_int()
  end

  defp keys_to_int(keys) do
    keys
    |> Enum.map(fn each -> Kernel.elem(each, 0) end)
    |> Enum.join()
    |> String.to_integer(2)
  end
end
