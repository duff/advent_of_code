defmodule Advent2021.Day01 do
  def increases(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reduce(&accumulate_increases/2)
    |> Kernel.elem(0)
  end

  def sliding_window_increases(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(3, 1)
    |> Enum.filter(fn each -> Enum.count(each) == 3 end)
    |> Enum.map(fn each -> Enum.sum(each) end)
    |> Enum.reduce(&accumulate_increases/2)
    |> Kernel.elem(0)
  end

  defp accumulate_increases(each, {increases, previous_element}) do
    if each > previous_element do
      {increases + 1, each}
    else
      {increases, each}
    end
  end

  defp accumulate_increases(second_element, first_element) do
    if second_element > first_element do
      {1, second_element}
    else
      {0, second_element}
    end
  end
end
