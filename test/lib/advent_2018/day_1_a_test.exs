defmodule Advent2018.Day1ATest do
  use ExUnit.Case

  alias Advent2018.Day1A

  test "example 1" do
    input = """
    +1
    -2
    +3
    +1
    """

    assert Day1A.calibrate(input) == 3
  end

  test "example 2" do
    input = """
    +1
    +1
    +1
    """

    assert Day1A.calibrate(input) == 3
  end

  test "example 3" do
    input = """
    +1
    +1
    -2
    """

    assert Day1A.calibrate(input) == 0
  end

  test "example 4" do
    input = """
    -1
    -2
    -3
    """

    assert Day1A.calibrate(input) == -6
  end
end
