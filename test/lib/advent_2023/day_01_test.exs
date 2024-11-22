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

  test "calibration_value_with_words" do
    assert Day01.calibration_value_with_words("pqr3stu8vwx") == 38
    assert Day01.calibration_value_with_words("4nineeightseven2") == 42
    assert Day01.calibration_value_with_words("xtwone3four") == 24
    assert Day01.calibration_value_with_words("7pqrstsixteen") == 76
    assert Day01.calibration_value_with_words("6huhoneight") == 68
    assert Day01.calibration_value_with_words("twone") == 21
    assert Day01.calibration_value_with_words("eightwo") == 82
    assert Day01.calibration_value_with_words("nineight") == 98
    assert Day01.calibration_value_with_words("eighthree") == 83
  end

  test "calibration_sum_with_words" do
    assert Day01.calibration_sum_with_words(input_words()) == 281
    assert Day01.calibration_sum_with_words(input()) == 142
  end

  test "calibration_sum_with_words real" do
    input = File.read!("test/lib/advent_2023/input/day_01.txt")
    assert Day01.calibration_sum_with_words(input) == 53_221
  end

  defp input do
    """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
  end

  defp input_words do
    """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
  end
end
