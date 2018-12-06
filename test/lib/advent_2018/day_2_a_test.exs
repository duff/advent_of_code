defmodule Advent2018.Day2ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day2A

  test "two?" do
    refute Day2A.two?("abcdef")
    assert Day2A.two?("bababc")
    assert Day2A.two?("abbcde")
    refute Day2A.two?("abcccd")
    assert Day2A.two?("aabcdd")
    assert Day2A.two?("abcdee")
    refute Day2A.two?("ababab")
  end

  test "three?" do
    refute Day2A.three?("abcdef")
    assert Day2A.three?("bababc")
    refute Day2A.three?("abbcde")
    assert Day2A.three?("abcccd")
    refute Day2A.three?("aabcdd")
    refute Day2A.three?("abcdee")
    assert Day2A.three?("ababab")
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

    assert Day2A.checksum(input) == 12
  end

  @tag :real
  test "checksum real input" do
    input = File.read!("test/lib/advent_2018/input/day2.txt") |> String.trim()
    assert Day2A.checksum(input) == 9139
  end
end
