defmodule Advent2018.Day01ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day01A

  test "example 1" do
    input = """
    +1
    -2
    +3
    +1
    """

    assert Day01A.calibrate(input) == 3
  end

  test "example 2" do
    input = """
    +1
    +1
    +1
    """

    assert Day01A.calibrate(input) == 3
  end

  test "example 3" do
    input = """
    +1
    +1
    -2
    """

    assert Day01A.calibrate(input) == 0
  end

  test "example 4" do
    input = """
    -1
    -2
    -3
    """

    assert Day01A.calibrate(input) == -6
  end

  test "example 5" do
    input = File.read!("test/lib/advent_2018/input/day_01.txt") |> String.trim()
    assert Day01A.calibrate(input) == 590
  end
end
