defmodule Advent2018.Day23Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day23

  test "part_a" do
    input = """
    pos=<0,0,0>, r=4
    pos=<1,0,0>, r=1
    pos=<4,0,0>, r=3
    pos=<0,2,0>, r=1
    pos=<0,5,0>, r=3
    pos=<0,0,3>, r=1
    pos=<1,1,1>, r=1
    pos=<1,1,2>, r=1
    pos=<1,3,1>, r=1
    """

    assert Day23.part_a(input) == 7
  end

  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_23.txt")
    assert Day23.part_a(input) == 172
  end
end
