defmodule Advent2021.Day14BTest do
  use ExUnit.Case, async: true

  alias Advent2021.Day14B

  test "most_common_minus_least_common" do
    assert Day14B.most_common_minus_least_common(input(), 1) == 1
    assert Day14B.most_common_minus_least_common(input(), 2) == 5
    assert Day14B.most_common_minus_least_common(input(), 3) == 7
    assert Day14B.most_common_minus_least_common(input(), 10) == 1588
  end

  test "most_common_minus_least_common real" do
    input = File.read!("test/lib/advent_2021/input/day_14.txt") |> String.trim()
    assert Day14B.most_common_minus_least_common(input, 10) == 3831
    assert Day14B.most_common_minus_least_common(input, 40) == 5_725_739_914_282
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
