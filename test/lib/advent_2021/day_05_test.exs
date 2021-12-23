defmodule Advent2021.Day05Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day05
  alias Advent2021.Day05.Segment

  test "overlapping_point_count" do
    assert Day05.overlapping_point_count(input()) == 5
  end

  test "overlapping_point_count real" do
    input = File.read!("test/lib/advent_2021/input/day_05.txt")
    assert Day05.overlapping_point_count(input) == 6572
  end

  test "overlapping_point_count_with_diagonals" do
    assert Day05.overlapping_point_count_with_diagonals(input()) == 12
  end

  @tag :real_data_slow
  test "overlapping_point_count_with_diagonals real" do
    input = File.read!("test/lib/advent_2021/input/day_05.txt")
    assert Day05.overlapping_point_count_with_diagonals(input) == 21466
  end

  describe "Segment" do
    test "hv_points" do
      assert Segment.hv_points(%Segment{x1: 7, y1: 0, x2: 7, y2: 4}) == [{7, 0}, {7, 1}, {7, 2}, {7, 3}, {7, 4}]
      assert Segment.hv_points(%Segment{x1: 3, y1: 4, x2: 1, y2: 4}) == [{3, 4}, {2, 4}, {1, 4}]
      assert Segment.hv_points(%Segment{x1: 3, y1: 7, x2: 1, y2: 4}) == []
    end

    test "diagonal_points" do
      assert Segment.diagonal_points(%Segment{x1: 1, y1: 1, x2: 3, y2: 3}) == [{2, 2}, {3, 3}, {1, 1}]
      assert Segment.diagonal_points(%Segment{x1: 9, y1: 7, x2: 7, y2: 9}) == [{8, 8}, {7, 9}, {9, 7}]
      assert Segment.diagonal_points(%Segment{x1: 3, y1: 7, x2: 1, y2: 4}) == []
    end
  end

  defp input do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end
end
