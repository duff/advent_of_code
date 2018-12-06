defmodule Advent2018.Day3ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day3A

  test "coordinates" do
    assert Day3A.coordinates("#3 @ 5,1: 2x3") == [{6, 2}, {6,3}, {6,4}, {7,2}, {7,3}, {7,4}]
  end

  test "difference_count" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

    assert Day3A.double_booked(input) == 4
  end

  @tag :real
  test "double_booked" do
    input = File.read!("test/lib/advent_2018/input/day3.txt") |> String.trim()
    assert Day3A.double_booked(input) == 101781
  end
end
