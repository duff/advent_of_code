defmodule Advent2021.Day08B do
  def sum_output_values(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&output_value/1)
    |> Enum.sum()
  end

  def output_value(input_line) do
    [signals, output] = String.split(input_line, [" | "])

    output
    |> String.split(" ")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn e -> convert(e, deduce(signals)) end)
    |> Integer.undigits()
  end

  defp convert(output, deduction) do
    deduction
    |> Enum.find(fn {_, value} -> MapSet.equal?(value, MapSet.new(output)) end)
    |> elem(0)
  end

  def deduce(signals) do
    signals
    |> String.split(" ")
    |> Enum.map(&String.to_charlist/1)
    |> deduce(%{})
  end

  defp deduce([signal = [_, _] | rest], result) do
    remember(1, signal, result, rest)
  end

  defp deduce([signal = [_, _, _] | rest], result) do
    remember(7, signal, result, rest)
  end

  defp deduce([signal = [_, _, _, _] | rest], result) do
    remember(4, signal, result, rest)
  end

  defp deduce([signal = [_, _, _, _, _, _, _] | rest], result) do
    remember(8, signal, result, rest)
  end

  defp deduce([signal = [_, _, _, _, _, _] | rest], result = %{9 => _, 6 => _}) do
    remember(0, signal, result, rest)
  end

  defp deduce([signal = [_, _, _, _, _] | rest], result = %{9 => nine, 8 => eight, 7 => seven}) do
    diff = MapSet.difference(eight, nine)

    if MapSet.subset?(diff, MapSet.new(signal)) do
      remember(2, signal, result, rest)
    else
      if MapSet.subset?(seven, MapSet.new(signal)) do
        remember(3, signal, result, rest)
      else
        remember(5, signal, result, rest)
      end
    end
  end

  defp deduce([signal = [_, _, _, _, _, _] | rest], result = %{4 => four, 7 => seven}) do
    if MapSet.subset?(four, MapSet.new(signal)) do
      remember(9, signal, result, rest)
    else
      if !MapSet.subset?(seven, MapSet.new(signal)) do
        remember(6, signal, result, rest)
      else
        move_to_end(signal, rest, result)
      end
    end
  end

  defp deduce([signal | rest], result) do
    move_to_end(signal, rest, result)
  end

  defp deduce([], result) do
    result
  end

  defp remember(number, signal, result, rest) do
    deduce(rest, Map.put(result, number, MapSet.new(signal)))
  end

  defp move_to_end(signal, rest, result) do
    deduce(rest ++ [signal], result)
  end
end
