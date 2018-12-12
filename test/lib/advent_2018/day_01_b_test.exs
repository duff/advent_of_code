defmodule Advent2018.Day01BTest do
  use ExUnit.Case, async: true

  alias Advent2018.Day01B

  test "example 1" do
    input = """
    +1
    -2
    +3
    +1
    """

    assert Day01B.first_duplicate(input) == 2
  end

  test "example 2" do
    input = """
    +1
    -1
    """

    assert Day01B.first_duplicate(input) == 0
  end

  test "example 3" do
    input = """
    +3
    +3
    +4
    -2
    -4
    """

    assert Day01B.first_duplicate(input) == 10
  end

  test "example 4" do
    input = """
    -6
    +3
    +8
    +5
    -6
    """

    assert Day01B.first_duplicate(input) == 5
  end

  test "example 5" do
    input = """
    +7
    +7
    -2
    -7
    -4
    """

    assert Day01B.first_duplicate(input) == 14
  end

  @tag :real
  test "example 6" do
    input = File.read!("test/lib/advent_2018/input/day1.txt") |> String.trim()
    assert Day01B.first_duplicate(input) == 83445
  end
end
