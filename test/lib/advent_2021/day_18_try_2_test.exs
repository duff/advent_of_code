defmodule Advent2021.Day18Try2Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day18

  test "simplest parse" do
    assert Day18.parse("[1,2]") == {[1,2], 0}
  end

  test "parse with left pair" do
    assert Day18.parse("[[1,2],3]") == {[{[1, 2], 0}, 3], 0}
  end

  test "parse with right pair" do
    assert Day18.parse("[9,[8,7]]") == {[9, {[8,7], 0}], 0}
  end

  test "parse with both pairs" do
    assert Day18.parse("[[1,9],[8,5]]") == {[{[1, 9], 0}, {[8, 5], 0}], 1}
  end

  test "parse bigger" do
    assert Day18.parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == {[{[{[{[1, 2], 0}, {[3, 4], 0}], 1}, {[{[5, 6], 0}, {[7,8], 0}], 1}], 2}, 9], 2}
  end

  test "add" do
    assert Day18.add(Day18.new([1, 2]), Day18.new([[3, 4], 5])) == Day18.new([[1, 2], [[3, 4], 5]])
  end

  test "magnitude" do
    assert Day18.magnitude(Day18.new([9, 1])) == 29
    assert Day18.magnitude(Day18.new([1, 9])) == 21
    assert Day18.magnitude(Day18.new([[9, 1], [1, 9]])) == 129
    assert Day18.magnitude(Day18.new([[1, 2], [[3, 4], 5]])) == 143
    assert Day18.magnitude(Day18.new([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])) == 1384
    assert Day18.magnitude(Day18.new([[[[1, 1], [2, 2]], [3, 3]], [4, 4]])) == 445
    assert Day18.magnitude(Day18.new([[[[5, 0], [7, 4]], [5, 5]], [6, 6]])) == 1137
    assert Day18.magnitude(Day18.new([[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]])) == 3488
  end

  # test "split" do
  #   assert Day18.split(Day18.new([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])) == {true, Day18.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])}
  #   assert Day18.split(Day18.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])) == {true, Day18.new([[[[0, 7], 4], [[7, 8], [0, [6, 7]]]], [1, 1]])}

  #   assert Day18.split(Day18.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])) ==
  #            {false, Day18.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])}
  # end

  # test "explode" do
  #   assert Day18.explode(Day18.new([[[[[9,8],1],2],3],4])) == Day18.new([[[[0,9],2],3],4])
  #   # assert Day18.explode(Day18.new([[6,[5,[4,[3,2]]]],1])) == Day18.new([[6,[5,[7,0]]],3])
  #   # assert Day18.explode(Day18.new([[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]])) == Day18.new([[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]])
  #   # assert Day18.explode(Day18.new([[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]])) == Day18.new([[3,[2,[8,0]]],[9,[5,[7,0]]]])
  # end
end
