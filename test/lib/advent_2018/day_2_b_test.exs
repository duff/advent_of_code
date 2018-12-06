defmodule Advent2018.Day2BTest do
  use ExUnit.Case, async: true

  alias Advent2018.Day2B

  test "difference_count" do
    assert Day2B.difference_count("abcde", "abcde") == 0
    assert Day2B.difference_count("abcde", "axcye") == 2
    assert Day2B.difference_count("fghij", "fguij") == 1
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

    assert Day2B.find_similar_common_letters(input) == "fgij"
  end

  @tag :real
  test "real input" do
    input = File.read!("test/lib/advent_2018/input/day2.txt") |> String.trim()
    assert Day2B.find_similar_common_letters(input) == "uqcidadzwtnhsljvxyobmkfyr"
  end
end
