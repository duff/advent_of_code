defmodule Advent2018.Day12 do
  def part_a(pots, generation_count, input) do
    {pots, padding_added_at_front} = generate(pots, generation_count, input)

    Enum.zip(-padding_added_at_front..length(pots), pots)
    |> Enum.filter(fn {_index, value} -> value == "#" end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def generate(pots, generation_count, input) do
    generate(String.codepoints(pots), generation_count, 0, notes(input))
  end

  def generate(pots, 0, padding_added_at_front, _) do
    {pots, padding_added_at_front}
  end

  def generate(pots, generation_count, padding_added_at_front, notes) do
    generate(next_gen(pots, notes), generation_count - 1, padding_added_at_front + 3, notes)
  end

  defp next_gen(pots, notes) do
    pots
    |> padded()
    |> Enum.chunk_every(5, 1)
    |> Enum.map(fn each ->
      Map.get(notes, each, ".")
    end)
  end

  defp padded(pots) do
    empty_pots = [".", ".", ".", ".", "."]
    empty_pots ++ pots ++ empty_pots
  end

  defp notes(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn each ->
      String.split(each, " => ")
    end)
    |> Map.new(fn [k, v] -> {String.codepoints(k), v} end)
  end
end
