defmodule Advent2018.Day2B do
  def difference_count(string_one, string_two) do
    one = String.graphemes(string_one)
    two = String.graphemes(string_two)

    Enum.zip(one, two)
    |> Enum.count(fn {a, b} -> a != b end)
  end

  def find_similar_common_letters(input) do
    strings = input |> String.split()

    Enum.reduce_while(strings, [], fn current_string, acc ->
      found = find_difference_of_one(strings, current_string)

      if found do
        {:halt, common_letters(current_string, found)}
      else
        {:cont, acc}
      end
    end)
  end

  defp find_difference_of_one(strings, current_string) do
    Enum.find(strings, fn each ->
      difference_count(current_string, each) == 1
    end)
  end

  defp common_letters(string_one, string_two) do
    one = String.graphemes(string_one)
    two = String.graphemes(string_two)
    zipped = Enum.zip(one, two)

    for({a, a} <- zipped, do: a)
    |> Enum.join()
  end
end
