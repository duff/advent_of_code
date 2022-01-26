defmodule Advent2021.Day18.Try3Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day18.Try3

  test "simplest parse" do
    assert Try3.parse("[1,2]") == {1, 2}
  end

  test "parse with left pair" do
    assert Try3.parse("[[1,2],3]") == {{1, 2}, 3}
  end

  test "parse with right pair" do
    assert Try3.parse("[9,[8,7]]") == {9, {8, 7}}
  end

  test "parse with both pairs" do
    assert Try3.parse("[[1,9],[8,5]]") == {{1, 9}, {8, 5}}
  end

  test "parse bigger" do
    assert Try3.parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == {{{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}}, 9}
  end

  test "add" do
    assert Try3.add({1, 2}, {{3, 4}, 5}) == {{1, 2}, {{3, 4}, 5}}
  end

  test "magnitude" do
    assert Try3.magnitude({9, 1}) == 29
    assert Try3.magnitude({1, 9}) == 21
    assert Try3.magnitude({{9, 1}, {1, 9}}) == 129
    assert Try3.magnitude({{1, 2}, {{3, 4}, 5}}) == 143
    assert Try3.magnitude({{{{0, 7}, 4}, {{7, 8}, {6, 0}}}, {8, 1}}) == 1384
    assert Try3.magnitude({{{{1, 1}, {2, 2}}, {3, 3}}, {4, 4}}) == 445
    assert Try3.magnitude({{{{5, 0}, {7, 4}}, {5, 5}}, {6, 6}}) == 1137
    assert Try3.magnitude({{{{8, 7}, {7, 7}}, {{8, 6}, {7, 7}}}, {{{0, 7}, {6, 6}}, {8, 7}}}) == 3488
  end

  test "split succeeds" do
    assert Try3.split({{{{0, 7}, 4}, {15, {0, 13}}}, {1, 1}}) == {true, {{{{0, 7}, 4}, {{7, 8}, {0, 13}}}, {1, 1}}}
    assert Try3.split({{{{0, 7}, 4}, {{7, 8}, {0, 13}}}, {1, 1}}) == {true, {{{{0, 7}, 4}, {{7, 8}, {0, {6, 7}}}}, {1, 1}}}
  end

  test "split not needed" do
    assert Try3.split({{{{{4, 3}, 4}, 4}, {7, {{8, 4}, 9}}}, {1, 1}}) == {false, {{{{{4, 3}, 4}, 4}, {7, {{8, 4}, 9}}}, {1, 1}}}
  end

  test "explode succeeds" do
    assert Try3.explode({{{{{9, 8}, 1}, 2}, 3}, 4}) == {true, {{{{0, 9}, 2}, 3}, 4}}
    assert Try3.explode({{6, {5, {4, {3, 2}}}}, 1}) == {true, {{6, {5, {7, 0}}}, 3}}
    assert Try3.explode({7, {6, {5, {4, {3, 2}}}}}) == {true, {7, {6, {5, {7, 0}}}}}
    assert Try3.explode({{3, {2, {1, {7, 3}}}}, {6, {5, {4, {3, 2}}}}}) == {true, {{3, {2, {8, 0}}}, {9, {5, {4, {3, 2}}}}}}
    assert Try3.explode({{3, {2, {8, 0}}}, {9, {5, {4, {3, 2}}}}}) == {true, {{3, {2, {8, 0}}}, {9, {5, {7, 0}}}}}
  end

  test "explode not needed" do
    assert Try3.explode({{{{0,7},4},{{7,8},{6,0}}},{8,1}}) == {false, {{{{0,7},4},{{7,8},{6,0}}},{8,1}}}
  end
end
