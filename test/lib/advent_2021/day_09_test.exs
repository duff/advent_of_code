defmodule Advent2021.Day09Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day09

  test "risk_level_sum" do
    assert Day09.risk_level_sum(input()) == 15
  end

  test "risk_level_sum real" do
    input = File.read!("test/lib/advent_2021/input/day_09.txt") |> String.trim()
    assert Day09.risk_level_sum(input) == 491
  end

  defp input do
    """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """
  end
end
