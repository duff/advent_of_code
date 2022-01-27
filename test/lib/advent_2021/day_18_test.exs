defmodule Advent2021.Day18Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day18

  test "simplest parse" do
    assert Day18.parse("[1,2]") == {1, 2}
  end

  test "parse with left pair" do
    assert Day18.parse("[[1,2],3]") == {{1, 2}, 3}
  end

  test "parse with right pair" do
    assert Day18.parse("[9,[8,7]]") == {9, {8, 7}}
  end

  test "parse with both pairs" do
    assert Day18.parse("[[1,9],[8,5]]") == {{1, 9}, {8, 5}}
  end

  test "parse bigger" do
    assert Day18.parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == {{{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}}, 9}
  end

  test "add" do
    assert Day18.add({1, 2}, {{3, 4}, 5}) == {{1, 2}, {{3, 4}, 5}}
  end

  test "magnitude" do
    assert Day18.magnitude({9, 1}) == 29
    assert Day18.magnitude({1, 9}) == 21
    assert Day18.magnitude({{9, 1}, {1, 9}}) == 129
    assert Day18.magnitude({{1, 2}, {{3, 4}, 5}}) == 143
    assert Day18.magnitude({{{{0, 7}, 4}, {{7, 8}, {6, 0}}}, {8, 1}}) == 1384
    assert Day18.magnitude({{{{1, 1}, {2, 2}}, {3, 3}}, {4, 4}}) == 445
    assert Day18.magnitude({{{{5, 0}, {7, 4}}, {5, 5}}, {6, 6}}) == 1137
    assert Day18.magnitude({{{{8, 7}, {7, 7}}, {{8, 6}, {7, 7}}}, {{{0, 7}, {6, 6}}, {8, 7}}}) == 3488
  end

  test "split succeeds" do
    assert Day18.split({{{{0, 7}, 4}, {15, {0, 13}}}, {1, 1}}) == {true, {{{{0, 7}, 4}, {{7, 8}, {0, 13}}}, {1, 1}}}
    assert Day18.split({{{{0, 7}, 4}, {{7, 8}, {0, 13}}}, {1, 1}}) == {true, {{{{0, 7}, 4}, {{7, 8}, {0, {6, 7}}}}, {1, 1}}}
  end

  test "split not needed" do
    assert Day18.split({{{{{4, 3}, 4}, 4}, {7, {{8, 4}, 9}}}, {1, 1}}) == {false, {{{{{4, 3}, 4}, 4}, {7, {{8, 4}, 9}}}, {1, 1}}}
  end

  test "explode succeeds" do
    assert Day18.explode({{{{{9, 8}, 1}, 2}, 3}, 4}) == {true, {{{{0, 9}, 2}, 3}, 4}}
    assert Day18.explode({{6, {5, {4, {3, 2}}}}, 1}) == {true, {{6, {5, {7, 0}}}, 3}}
    assert Day18.explode({7, {6, {5, {4, {3, 2}}}}}) == {true, {7, {6, {5, {7, 0}}}}}
    assert Day18.explode({{3, {2, {1, {7, 3}}}}, {6, {5, {4, {3, 2}}}}}) == {true, {{3, {2, {8, 0}}}, {9, {5, {4, {3, 2}}}}}}
    assert Day18.explode({{3, {2, {8, 0}}}, {9, {5, {4, {3, 2}}}}}) == {true, {{3, {2, {8, 0}}}, {9, {5, {7, 0}}}}}
  end

  test "explode not needed" do
    assert Day18.explode({{{{0, 7}, 4}, {{7, 8}, {6, 0}}}, {8, 1}}) == {false, {{{{0, 7}, 4}, {{7, 8}, {6, 0}}}, {8, 1}}}
  end

  test "explode_and_split reduction" do
    added = Day18.add({{{{4, 3}, 4}, 4}, {7, {{8, 4}, 9}}}, {1, 1})
    reduced = Day18.explode_split(added)
    assert reduced == {{{{0, 7}, 4}, {{7, 8}, {6, 0}}}, {8, 1}}
  end

  test "add and reduce" do
    assert Day18.add_and_reduce(simple_input()) == {{{{4, 0}, {5, 4}}, {{7, 7}, {6, 0}}}, {{8, {7, 7}}, {{7, 9}, {5, 0}}}}
  end

  @tag :real_data_slow
  test "part one" do
    assert Day18.part_one(input()) == 4140
  end

  @tag :real_data_slow
  test "part_one real" do
    input = File.read!("test/lib/advent_2021/input/day_18.txt") |> String.trim()
    assert Day18.part_one(input) == 2907
  end

  @tag :real_data_slow
  test "part two" do
    assert Day18.part_two(input()) == 3993
  end

  @tag :real_data_slow
  test "part_two real" do
    input = File.read!("test/lib/advent_2021/input/day_18.txt") |> String.trim()
    assert Day18.part_two(input) == 4690
  end

  defp simple_input do
    """
    [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
    [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
    """
  end

  defp input do
    """
    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
    [[[5,[2,8]],4],[5,[[9,9],0]]]
    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
    [[[[5,4],[7,7]],8],[[8,3],8]]
    [[9,3],[[9,9],[6,[4,9]]]]
    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
    """
  end
end
