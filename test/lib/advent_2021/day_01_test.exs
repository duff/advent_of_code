defmodule Advent2021.Day01Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day01

  test "increases" do
    assert Day01.increases(input()) == 7
  end

  test "sliding_window_increases" do
    assert Day01.sliding_window_increases(input()) == 5
  end

  test "increases real" do
    input = File.read!("test/lib/advent_2021/input/day_01.txt")
    assert Day01.increases(input) == 1553
  end

  test "sliding_window_increases real" do
    input = File.read!("test/lib/advent_2021/input/day_01.txt")
    assert Day01.sliding_window_increases(input) == 1597
  end

  defp input do
    """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """
  end
end
