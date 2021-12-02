defmodule Advent2018.Day03ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day03A

  test "coordinates" do
    assert Day03A.coordinates("#3 @ 5,1: 2x3") == [{6, 2}, {6, 3}, {6, 4}, {7, 2}, {7, 3}, {7, 4}]
  end

  test "difference_count" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

    assert Day03A.double_booked(input) == 4
  end

  test "double_booked" do
    input = File.read!("test/lib/advent_2018/input/day_03.txt") |> String.trim()
    assert Day03A.double_booked(input) == 101_781
  end
end
