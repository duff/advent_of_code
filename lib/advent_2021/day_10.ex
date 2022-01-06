defmodule Advent2021.Day10 do
  def syntax_error_score(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&line_score/1)
    |> Enum.sum()
  end

  def middle_completion_score(input) do
    scores =
      input
      |> String.split("\n", trim: true)
      |> Enum.filter(&(line_score(&1) == 0))
      |> Enum.map(&completetion_score/1)
      |> Enum.sort()

    Enum.at(scores, div(length(scores), 2))
  end

  def line_score(line) do
    line
    |> String.graphemes()
    |> process([])
    |> elem(0)
  end

  def completetion_score(line) do
    line
    |> String.graphemes()
    |> process([])
    |> elem(1)
    |> Enum.reduce(0, &score/2)
  end

  defp score("{", acc), do: acc * 5 + 3
  defp score("(", acc), do: acc * 5 + 1
  defp score("[", acc), do: acc * 5 + 2
  defp score("<", acc), do: acc * 5 + 4

  defp process([open_symbol | rest], stack) when open_symbol in ["(", "[", "{", "<"] do
    process(rest, [open_symbol | stack])
  end

  defp process(["]" | rest], ["[" | remaining_stack]), do: process(rest, remaining_stack)
  defp process([")" | rest], ["(" | remaining_stack]), do: process(rest, remaining_stack)
  defp process(["}" | rest], ["{" | remaining_stack]), do: process(rest, remaining_stack)
  defp process([">" | rest], ["<" | remaining_stack]), do: process(rest, remaining_stack)

  defp process([], stack), do: {0, stack}

  defp process(["]" | _rest], stack), do: {57, stack}
  defp process([">" | _rest], stack), do: {25137, stack}
  defp process(["}" | _rest], stack), do: {1197, stack}
  defp process([")" | _rest], stack), do: {3, stack}
end
