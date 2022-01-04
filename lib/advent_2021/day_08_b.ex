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
    deduce(rest, Map.put(result, 1, MapSet.new(signal)))
  end

  defp deduce([signal = [_, _, _] | rest], result) do
    deduce(rest, Map.put(result, 7, MapSet.new(signal)))
  end

  defp deduce([signal = [_, _, _, _] | rest], result) do
    deduce(rest, Map.put(result, 4, MapSet.new(signal)))
  end

  defp deduce([signal = [_, _, _, _, _, _, _] | rest], result) do
    deduce(rest, Map.put(result, 8, MapSet.new(signal)))
  end

  defp deduce([signal = [_, _, _, _, _, _] | rest], result = %{9 => _, 6 => _}) do
    deduce(rest, Map.put(result, 0, MapSet.new(signal)))
  end

  defp deduce([signal = [_, _, _, _, _] | rest], result = %{9 => nine, 8 => eight, 7 => seven}) do
    diff = MapSet.difference(eight, nine)

    if MapSet.subset?(diff, MapSet.new(signal)) do
      deduce(rest, Map.put(result, 2, MapSet.new(signal)))
    else
      if MapSet.subset?(seven, MapSet.new(signal)) do
        deduce(rest, Map.put(result, 3, MapSet.new(signal)))
      else
        deduce(rest, Map.put(result, 5, MapSet.new(signal)))
      end
    end
  end

  defp deduce([signal = [_, _, _, _, _, _] | rest], result = %{4 => four, 7 => seven}) do
    if MapSet.subset?(four, MapSet.new(signal)) do
      deduce(rest, Map.put(result, 9, MapSet.new(signal)))
    else
      if !MapSet.subset?(seven, MapSet.new(signal)) do
        deduce(rest, Map.put(result, 6, MapSet.new(signal)))
      else
        deduce(rest ++ [signal], result)
      end
    end
  end

  defp deduce([signal | rest], result) do
    deduce(rest ++ [signal], result)
  end

  defp deduce([], result) do
    result
  end
end
