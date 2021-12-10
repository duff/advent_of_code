defmodule Advent2021.Day03 do
  def power_consumption(input) do
    f = input |> graphemes() |> frequencies
    gamma_rate(f) * epsilon_rate(f)
  end

  def life_support_rating(input) do
    oxygen_generator_rating(input) * carbon_dioxide_scrubber_rating(input)
  end

  defp carbon_dioxide_scrubber_rating(input) do
    list = graphemes(input)

    Enum.reduce_while(0..Enum.count(list), list, fn e, acc ->
      if Enum.count(acc) == 1 do
        {:halt, acc}
      else
        {:cont, select_min_at(acc, e)}
      end
    end)
    |> to_int()
  end

  defp oxygen_generator_rating(input) do
    list = graphemes(input)

    Enum.reduce_while(0..Enum.count(list), list, fn e, acc ->
      if Enum.count(acc) == 1 do
        {:halt, acc}
      else
        {:cont, select_max_at(acc, e)}
      end
    end)
    |> to_int()
  end

  defp select_max_at(list, position) do
    Enum.filter(list, fn e -> Enum.at(e, position) == max_filter(list, position) end)
  end

  defp select_min_at(list, position) do
    Enum.filter(list, fn e -> Enum.at(e, position) == min_filter(list, position) end)
  end

  defp max_filter(list, position) do
    f = frequencies_at_position(list, position)

    if Map.get(f, "1") >= Map.get(f, "0") do
      "1"
    else
      "0"
    end
  end

  defp min_filter(list, position) do
    f = frequencies_at_position(list, position)

    if Map.get(f, "0") <= Map.get(f, "1") do
      "0"
    else
      "1"
    end
  end

  defp frequencies_at_position(list, position) do
    list |> frequencies() |> Enum.at(position)
  end

  defp graphemes(input) do
    input
    |> String.split()
    |> Enum.map(&String.graphemes/1)
  end

  defp frequencies(graphemes) do
    graphemes
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
    |> to_int()
  end

  defp to_int(list) do
    list
    |> Enum.join()
    |> String.to_integer(2)
  end
end
