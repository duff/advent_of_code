defmodule Advent2018.Day12 do
  def part_a(pots, generation_count, input) do
    {pots, index_of_pot_zero} = generate(pots, generation_count, input)

    Enum.zip(-index_of_pot_zero..(length(pots) - 1 + index_of_pot_zero), pots)
    |> Enum.filter(fn {_index, value} -> value == "#" end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def generate(pots, generation_count, input) do
    generate(prepped_pots(pots), generation_count, 1000, notes(input))
  end

  def generate(pots, 0, index_of_pot_zero, _) do
    {pots, index_of_pot_zero}
  end

  def generate(pots, generation_count, index_of_pot_zero, notes) do
    next_gen =
      pots
      |> Enum.chunk_every(5, 1)
      |> Enum.map(fn each ->
        Map.get(notes, each, ".")
      end)

    generate(next_gen, generation_count - 1, index_of_pot_zero - 5, notes)
  end

  defp prepped_pots(pots) do
    initial_length = String.length(pots)

    pots
    |> String.pad_leading(initial_length + 1000, ".")
    |> String.pad_trailing(initial_length + 2000, ".")
    |> String.codepoints()
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
