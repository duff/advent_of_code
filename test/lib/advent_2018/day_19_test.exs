defmodule Advent2018.Day19Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day19

  test "part_a" do
    input = """
    #ip 0
    seti 5 0 1
    seti 6 0 2
    addi 0 1 0
    addr 1 2 3
    setr 1 0 0
    seti 8 0 4
    seti 9 0 5
    """

    assert Day19.part_a(input) == 7
  end

  @tag :real
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_19.txt")
    assert Day19.part_a(input) == 888
  end
end
