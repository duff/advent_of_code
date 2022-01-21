defmodule Advent2021.Day18Test do
  use ExUnit.Case, async: true

  test "simplest parse" do
    assert SNum.parse("[1,2]") == %SNum{left: 1, right: 2}
  end

  test "parse with left pair" do
    assert SNum.parse("[[1,2],3]") == %SNum{left: %SNum{left: 1, right: 2}, right: 3}
  end

  test "parse with right pair" do
    assert SNum.parse("[9,[8,7]]") == %SNum{left: 9, right: %SNum{left: 8, right: 7}}
  end

  test "parse with both pairs" do
    assert SNum.parse("[[1,9],[8,5]]") == %SNum{left: %SNum{left: 1, right: 9}, right: %SNum{left: 8, right: 5}}
  end

  test "parse bigger" do
    expected = %SNum{
      left: %SNum{
        left: %SNum{left: %SNum{left: 1, right: 2}, right: %SNum{left: 3, right: 4}},
        right: %SNum{left: %SNum{left: 5, right: 6}, right: %SNum{left: 7, right: 8}}
      },
      right: 9
    }

    assert SNum.parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == expected
  end

  test "add" do
    assert SNum.add(SNum.new([1, 2]), SNum.new([[3, 4], 5])) == SNum.new([[1, 2], [[3, 4], 5]])
  end

  test "magnitude" do
    assert SNum.magnitude(SNum.new([9, 1])) == 29
    assert SNum.magnitude(SNum.new([1, 9])) == 21
    assert SNum.magnitude(SNum.new([[9, 1], [1, 9]])) == 129
    assert SNum.magnitude(SNum.new([[1, 2], [[3, 4], 5]])) == 143
    assert SNum.magnitude(SNum.new([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])) == 1384
    assert SNum.magnitude(SNum.new([[[[1, 1], [2, 2]], [3, 3]], [4, 4]])) == 445
    assert SNum.magnitude(SNum.new([[[[5, 0], [7, 4]], [5, 5]], [6, 6]])) == 1137
    assert SNum.magnitude(SNum.new([[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]])) == 3488
  end

  test "split" do
    assert SNum.split(SNum.new([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])) == {true, SNum.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])}
    assert SNum.split(SNum.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])) == {true, SNum.new([[[[0, 7], 4], [[7, 8], [0, [6, 7]]]], [1, 1]])}
    assert SNum.split(SNum.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])) == {false, SNum.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])}
  end
end
