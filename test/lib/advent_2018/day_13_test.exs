defmodule Advent2018.Day13Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day13

  test "part_a simplest track" do
    input = """
    |
    v
    |
    |
    |
    ^
    |
    """

    assert Day13.part_a(input) == {0, 3}
  end

  test "part_a larger track" do
    input = ~S"""
    /->-\
    |   |  /----\
    | /-+--+-\  |
    | | |  | v  |
    \-+-/  \-+--/
      \------/
    """

    assert Day13.part_a(input) == {7, 3}
  end

  test "part_b" do
    input = ~S"""
    />-<\
    |   |
    | /<+-\
    | | | v
    \>+</ |
      |   ^
      \<->/
    """

    assert Day13.part_b(input) == {6, 4}
  end

  @tag :real_data_slow
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_13.txt")
    assert Day13.part_a(input) == {119, 41}
  end

  @tag :real_data_slow
  test "part_b real" do
    input = File.read!("test/lib/advent_2018/input/day_13.txt")
    assert Day13.part_b(input) == {45, 136}
  end
end
