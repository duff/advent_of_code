defmodule Advent2021.Day10 do
  def syntax_error_score(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&line_score/1)
    |> Enum.sum
  end

  def line_score(line) do
    line_score(String.graphemes(line), [])
  end

  defp line_score([open_symbol | rest], stack) when open_symbol in ["(", "[", "{", "<"] do
    line_score(rest, [open_symbol | stack])
  end

  defp line_score(["]" | rest], ["[" | remaining_stack]) do
    line_score(rest, remaining_stack)
  end

  defp line_score([")" | rest], ["(" | remaining_stack]) do
    line_score(rest, remaining_stack)
  end

  defp line_score(["}" | rest], ["{" | remaining_stack]) do
    line_score(rest, remaining_stack)
  end

  defp line_score([">" | rest], ["<" | remaining_stack]) do
    line_score(rest, remaining_stack)
  end

  defp line_score([], _stack) do
    0
  end

  defp line_score(["]" | _rest], _stack), do: 57
  defp line_score([">" | _rest], _stack), do: 25137
  defp line_score(["}" | _rest], _stack), do: 1197
  defp line_score([")" | _rest], _stack), do: 3
end
