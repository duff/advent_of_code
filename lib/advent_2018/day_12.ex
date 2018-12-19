defmodule Advent2018.Day12 do
  def part_a(pots, generation_count, input) do
    {pots, index_of_pot_zero} = generate(pots, generation_count, input)

    Enum.zip(-index_of_pot_zero..(length(pots) - 1 + index_of_pot_zero), pots)
    |> Enum.filter(fn {_index, value} -> value == "#" end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def generate(pots, generation_count, input) do
    generate(String.codepoints(pots), generation_count, 0, notes(input))
  end

  def generate(pots, 0, index_of_pot_zero, _) do
    {pots, index_of_pot_zero}
  end

  def generate([".", ".", "." | _rest] = pots, generation_count, index_of_pot_zero, notes) do
    next_gen =
      pots
      |> add_more_empty_pots_at_end()
      |> Enum.chunk_every(5, 1)
      |> Enum.map(fn each -> Map.get(notes, each, ".") end)

    generate(next_gen, generation_count - 1, index_of_pot_zero - 2, notes)
  end

  def generate(["#" | _rest] = pots, generation_count, index_of_pot_zero, notes) do
    generate([".", ".", "." | pots], generation_count, index_of_pot_zero + 3, notes)
  end

  def generate([".", "#" | _rest] = pots, generation_count, index_of_pot_zero, notes) do
    generate([".", "." | pots], generation_count, index_of_pot_zero + 2, notes)
  end

  def generate([".", ".", "#" | _rest] = pots, generation_count, index_of_pot_zero, notes) do
    generate(["." | pots], generation_count, index_of_pot_zero + 1, notes)
  end

  def add_more_empty_pots_at_end(pots) do
    case Enum.take(pots, -3) do
      [".", ".", "."] -> pots
      ["#", ".", "."] -> pots ++ ["."]
      [_, "#", "."] -> pots ++ [".", "."]
      [_, _, "#"] -> pots ++ [".", ".", "."]
    end
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
