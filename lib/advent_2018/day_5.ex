defmodule Advent2018.Day5 do
  def num_units(charlist) do
    {_, reacted} = react(charlist, {nil, []})

    reacted
    |> length
  end

  def shortest_length(input) do
    charlist = input |> String.to_charlist()

    ?A..?Z
    |> Enum.map(fn char ->
      charlist
      |> Enum.reject(&(&1 == char || &1 == char + 32))
      |> num_units()
    end)
    |> Enum.min()
  end

  def run_all_reactions(input) do
    {_, reacted} = react(input)

    reacted
    |> Enum.reverse()
    |> to_string()
  end

  defp react(input) when is_binary(input) do
    input
    |> String.to_charlist()
    |> react({nil, []})
  end

  defp react([head | tail], {previous_char, acc}) do
    if reactive(head, previous_char) do
      react(Enum.reverse(tl(acc)) ++ tail, {nil, []})
    else
      react(tail, {head, [head | acc]})
    end
  end

  defp react([], acc) do
    acc
  end

  defp reactive(_, nil), do: false

  defp reactive(one, two) do
    abs(one - two) == 32
  end
end
