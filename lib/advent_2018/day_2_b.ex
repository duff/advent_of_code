defmodule Advent2018.Day2B do
  def difference_count(string_one, string_two) do
    one = String.graphemes(string_one)
    two = String.graphemes(string_two)

    Enum.zip(one, two)
    |> Enum.count(fn({a, b}) -> a != b end)
  end

  def find_similar(input) do
    strings = input |> String.split()

    Enum.reduce_while(strings, [], fn string_one , acc ->
      found = Enum.find(strings, fn each ->
        difference_count(string_one, each) == 1
      end)

      if found do
        {:halt, [string_one, found]}
      else
        {:cont, acc}
      end
    end)
  end

  def remove_differences(string_one, string_two) do
    one = String.graphemes(string_one)
    two = String.graphemes(string_two)
    zipped = Enum.zip(one, two)

    same = for {a, a} <- zipped, do: a
    Enum.join(same)
  end
end
