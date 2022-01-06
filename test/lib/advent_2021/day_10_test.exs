defmodule Advent2021.Day10Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day10

  test "syntax_error_score" do
    assert Day10.syntax_error_score(input()) == 26397
  end

  test "syntax_error_score real" do
    input = File.read!("test/lib/advent_2021/input/day_10.txt") |> String.trim()
    assert Day10.syntax_error_score(input) == 339_411
  end

  test "line_score legit lines" do
    assert Day10.line_score("([])") == 0
    assert Day10.line_score("(((((((((())))))))))") == 0
    assert Day10.line_score("[]") == 0
    assert Day10.line_score("{()()()}") == 0
    assert Day10.line_score("<([{}])>") == 0
    assert Day10.line_score("[<>({}){}[([])<>]]") == 0
  end

  test "line_score corrupted lines" do
    assert Day10.line_score("(]") == 57
    assert Day10.line_score("{()()()>") == 25137
    assert Day10.line_score("(((()))}") == 1197
    assert Day10.line_score("<([]){()}[{}])") == 3
  end

  defp input do
    """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
  end
end
