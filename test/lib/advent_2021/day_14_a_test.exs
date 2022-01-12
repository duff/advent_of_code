defmodule Advent2021.Day14ATest do
  use ExUnit.Case, async: true

  alias Advent2021.Day14A

  test "insert_pairs" do
    assert Day14A.insert_pairs(input(), 1) == "NCNBCHB"
    assert Day14A.insert_pairs(input(), 2) == "NBCCNBBBCBHCB"
    assert Day14A.insert_pairs(input(), 3) == "NBBBCNCCNBBNBNBBCHBHHBCHB"
    assert Day14A.insert_pairs(input(), 4) == "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
  end

  test "most_common_minus_least_common" do
    assert Day14A.most_common_minus_least_common(input(), 1) == 1
    assert Day14A.most_common_minus_least_common(input(), 2) == 5
    assert Day14A.most_common_minus_least_common(input(), 3) == 7
    assert Day14A.most_common_minus_least_common(input(), 10) == 1588
  end

  test "most_common_minus_least_common real" do
    input = File.read!("test/lib/advent_2021/input/day_14.txt") |> String.trim()
    assert Day14A.most_common_minus_least_common(input, 10) == 3831
  end

  defp input do
    """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """
  end
end
