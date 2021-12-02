defmodule Advent2018.Day02BTest do
  use ExUnit.Case, async: true

  alias Advent2018.Day02B

  test "difference_count" do
    assert Day02B.difference_count("abcde", "abcde") == 0
    assert Day02B.difference_count("abcde", "axcye") == 2
    assert Day02B.difference_count("fghij", "fguij") == 1
  end

  test "find_similar_common_letters" do
    input = """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """

    assert Day02B.find_similar_common_letters(input) == "fgij"
  end

  test "real input" do
    input = File.read!("test/lib/advent_2018/input/day_02.txt") |> String.trim()
    assert Day02B.find_similar_common_letters(input) == "uqcidadzwtnhsljvxyobmkfyr"
  end
end
