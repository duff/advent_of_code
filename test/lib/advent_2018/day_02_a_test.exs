defmodule Advent2018.Day02ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day02A

  test "two?" do
    refute Day02A.two?("abcdef")
    assert Day02A.two?("bababc")
    assert Day02A.two?("abbcde")
    refute Day02A.two?("abcccd")
    assert Day02A.two?("aabcdd")
    assert Day02A.two?("abcdee")
    refute Day02A.two?("ababab")
  end

  test "three?" do
    refute Day02A.three?("abcdef")
    assert Day02A.three?("bababc")
    refute Day02A.three?("abbcde")
    assert Day02A.three?("abcccd")
    refute Day02A.three?("aabcdd")
    refute Day02A.three?("abcdee")
    assert Day02A.three?("ababab")
  end

  test "checksum" do
    input = """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    assert Day02A.checksum(input) == 12
  end

  test "checksum real input" do
    input = File.read!("test/lib/advent_2018/input/day_02.txt") |> String.trim()
    assert Day02A.checksum(input) == 9139
  end
end
