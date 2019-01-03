defmodule Advent2018.Day17Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day17

  test "part_a" do
    input = """
    x=495, y=2..7
    y=7, x=495..501
    x=501, y=3..7
    x=498, y=2..4
    x=506, y=1..2
    x=498, y=10..13
    x=504, y=10..13
    y=13, x=498..504
    """

    assert Day17.part_a(input) == 57
  end

  test "part_a enhanced" do
    input = """
    x=495, y=2..7
    y=7, x=495..501
    x=501, y=3..7
    x=498, y=2..4
    x=506, y=1..2
    x=498, y=10..13
    x=504, y=10..13
    y=13, x=498..504
    y=23, x=492..538
    x=492, y=18..23
    x=538, y=18..23
    y=33, x=531..542
    x=531, y=31..33
    x=542, y=31..33
    """

    assert Day17.part_a(input) == 405
  end

  @tag :real
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_17.txt")
    assert Day17.part_a(input) == 7704
  end
end
