defmodule Advent2018.Day12.PotData do
  defstruct pots: [],
            notes: nil,
            generations_processed: 0,
            remaining_generations: nil,
            previous_sum: 0,
            previous_delta: 0,
            padding_added_at_front: 0,
            total_sum: 0
end

defmodule Advent2018.Day12 do
  alias Advent2018.Day12.PotData

  def part_a(pots, generation_count, input_notes) do
    initialize(pots, input_notes, generation_count)
    |> generate
    |> pot_sum
  end

  def part_b(pots, input_notes) do
    initialize(pots, input_notes, 50_000_000_000)
    |> generate_until_same_delta
    |> pot_sum_using_same_delta
  end

  def generate(%PotData{remaining_generations: 0} = data) do
    data
  end

  def generate(data) do
    data
    |> next_generation
    |> generate
  end

  def generate_until_same_delta(data) do
    new_data = next_generation(data)
    old_sum = pot_sum(data)
    new_sum = pot_sum(new_data)
    new_delta = new_sum - old_sum

    if new_delta == data.previous_delta do
      data
    else
      %PotData{new_data | previous_delta: new_delta, previous_sum: new_sum}
      |> generate_until_same_delta
    end
  end

  defp decrement_remaining_generations(data) do
    %PotData{data | remaining_generations: data.remaining_generations - 1}
  end

  defp increment_generations_processed(data) do
    %PotData{data | generations_processed: data.generations_processed + 1}
  end

  defp increment_padding_count(data) do
    %PotData{data | padding_added_at_front: data.padding_added_at_front + 3}
  end

  defp initialize(pots, input_notes, generation_count) do
    %PotData{pots: String.codepoints(pots), notes: notes(input_notes), remaining_generations: generation_count}
  end

  defp next_generation(%PotData{pots: pots, notes: notes} = data) do
    new_pots =
      pots
      |> padded
      |> Enum.chunk_every(5, 1)
      |> Enum.map(fn each ->
        Map.get(notes, each, ".")
      end)

    %PotData{data | pots: new_pots}
    |> decrement_remaining_generations
    |> increment_generations_processed
    |> increment_padding_count
  end

  defp pot_sum(%PotData{pots: pots, padding_added_at_front: padding}) do
    -padding..length(pots)
    |> Enum.zip(pots)
    |> Enum.filter(fn {_index, value} -> value == "#" end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp pot_sum_using_same_delta(data) do
    data.remaining_generations * data.previous_delta + data.previous_sum
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
