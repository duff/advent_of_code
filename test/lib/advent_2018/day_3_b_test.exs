defmodule Advent2018.Day3BTest do
  use ExUnit.Case, async: true

  alias Advent2018.Day3B

  test "pristine" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    #4 @ 3,1: 4x4
    """

    assert Day3B.pristine(input) == 3
  end

  @tag :real
  test "pristine with real value" do
    input = File.read!("test/lib/advent_2018/input/day3.txt") |> String.trim()
    assert Day3B.pristine(input) == 909
  end
end
