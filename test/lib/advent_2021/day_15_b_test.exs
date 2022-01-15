defmodule Advent2021.Day15BTest do
  use ExUnit.Case, async: true

  alias Advent2021.Day15B

  test "lowest_risk_amount" do
    assert Day15B.lowest_risk_amount(input()) == 315
  end

  @tag :real_data_slow
  test "lowest_risk_amount real" do
    input = File.read!("test/lib/advent_2021/input/day_15.txt") |> String.trim()
    assert Day15B.lowest_risk_amount(input) == 1350
  end

  defp input do
    """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """
  end
end
