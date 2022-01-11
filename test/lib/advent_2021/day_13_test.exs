defmodule Advent2021.Day13Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day13

  test "dot_count_after_first_fold" do
    assert Day13.dot_count_after_first_fold(input()) == 17
  end

  test "dot_count_after_first_fold real" do
    input = File.read!("test/lib/advent_2021/input/day_13.txt") |> String.trim()
    assert Day13.dot_count_after_first_fold(input) == 671
  end

  defp input do
    """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """
  end

end
