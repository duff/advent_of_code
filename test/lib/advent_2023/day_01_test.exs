defmodule Advent2023.Day01Test do
  use ExUnit.Case, async: true

  alias Advent2023.Day01

  test "calibration_value" do
    assert Day01.calibration_value("1abc2") == 12
    assert Day01.calibration_value("pqr3stu8vwx") == 38
    assert Day01.calibration_value("a1b2c3d4e5f") == 15
    assert Day01.calibration_value("treb7uchet") == 77
  end

  test "calibration_sum" do
    assert Day01.calibration_sum(input()) == 142
  end

  test "calibration_sum real" do
    input = File.read!("test/lib/advent_2023/input/day_01.txt")
    assert Day01.calibration_sum(input) == 55_834
  end

  defp input do
    """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
  end
end
