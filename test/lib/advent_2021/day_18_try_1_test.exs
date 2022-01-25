defmodule Advent2021.Day18Try1Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day18.Try1

  test "simplest parse" do
    assert Try1.parse("[1,2]") == %Try1{left: 1, right: 2}
  end

  test "parse with left pair" do
    assert Try1.parse("[[1,2],3]") == %Try1{left: %Try1{left: 1, right: 2}, right: 3}
  end

  test "parse with right pair" do
    assert Try1.parse("[9,[8,7]]") == %Try1{left: 9, right: %Try1{left: 8, right: 7}}
  end

  test "parse with both pairs" do
    assert Try1.parse("[[1,9],[8,5]]") == %Try1{left: %Try1{left: 1, right: 9}, right: %Try1{left: 8, right: 5}}
  end

  test "parse bigger" do
    expected = %Try1{
      left: %Try1{
        left: %Try1{left: %Try1{left: 1, right: 2}, right: %Try1{left: 3, right: 4}},
        right: %Try1{left: %Try1{left: 5, right: 6}, right: %Try1{left: 7, right: 8}}
      },
      right: 9
    }

    assert Try1.parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == expected
  end

  test "add" do
    assert Try1.add(Try1.new([1, 2]), Try1.new([[3, 4], 5])) == Try1.new([[1, 2], [[3, 4], 5]])
  end

  test "magnitude" do
    assert Try1.magnitude(Try1.new([9, 1])) == 29
    assert Try1.magnitude(Try1.new([1, 9])) == 21
    assert Try1.magnitude(Try1.new([[9, 1], [1, 9]])) == 129
    assert Try1.magnitude(Try1.new([[1, 2], [[3, 4], 5]])) == 143
    assert Try1.magnitude(Try1.new([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])) == 1384
    assert Try1.magnitude(Try1.new([[[[1, 1], [2, 2]], [3, 3]], [4, 4]])) == 445
    assert Try1.magnitude(Try1.new([[[[5, 0], [7, 4]], [5, 5]], [6, 6]])) == 1137
    assert Try1.magnitude(Try1.new([[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]])) == 3488
  end

  test "split" do
    assert Try1.split(Try1.new([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])) == {true, Try1.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])}
    assert Try1.split(Try1.new([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])) == {true, Try1.new([[[[0, 7], 4], [[7, 8], [0, [6, 7]]]], [1, 1]])}
    assert Try1.split(Try1.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])) == {false, Try1.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])}
  end
end
