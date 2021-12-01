defmodule Advent2018.Day10Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day10
  alias Advent2018.Day10.{Position, Rectangle}

  test "to_positions" do
    input = """
    position=<-3,  6> velocity=< 2, -1>
    position=<14,  7> velocity=<-2,  0>
    position=< -9988, -51087> velocity=< 1,  5>
    """

    expected = [
      %Position{x: -3, y: 6, velocity_x: 2, velocity_y: -1},
      %Position{x: 14, y: 7, velocity_x: -2, velocity_y: 0},
      %Position{x: -9988, y: -51087, velocity_x: 1, velocity_y: 5}
    ]

    assert Day10.to_positions(input) == expected
  end

  test "move" do
    position = %Position{x: 3, y: 9, velocity_x: 1, velocity_y: -2}
    assert %Position{x: 4, y: 7} = Day10.move(position)
  end

  test "bounding_rectangle" do
    positions = Day10.to_positions(example_input())
    assert %Rectangle{top_left: {-7, -5}, bottom_right: {16, 12}} == Day10.bounding_rectangle(positions)
  end

  test "area of rectangle" do
    rect = %Rectangle{top_left: {-2, -3}, bottom_right: {4, 5}}
    assert Rectangle.area(rect) == 48
  end

  test "smallest_sky" do
    positions = Day10.to_positions(example_input())
    assert {_positions, 99, _seconds} = Day10.smallest_sky(positions)
  end

  defp example_input do
    """
    position=< 9,  1> velocity=< 0,  2>
    position=< 7,  0> velocity=<-1,  0>
    position=< 3, -2> velocity=<-1,  1>
    position=< 6, 10> velocity=<-2, -1>
    position=< 2, -4> velocity=< 2,  2>
    position=<-6, 10> velocity=< 2, -2>
    position=< 1,  8> velocity=< 1, -1>
    position=< 1,  7> velocity=< 1,  0>
    position=<-3, 11> velocity=< 1, -2>
    position=< 7,  6> velocity=<-1, -1>
    position=<-2,  3> velocity=< 1,  0>
    position=<-4,  3> velocity=< 2,  0>
    position=<10, -3> velocity=<-1,  1>
    position=< 5, 11> velocity=< 1, -2>
    position=< 4,  7> velocity=< 0, -1>
    position=< 8, -2> velocity=< 0,  1>
    position=<15,  0> velocity=<-2,  0>
    position=< 1,  6> velocity=< 1,  0>
    position=< 8,  9> velocity=< 0, -1>
    position=< 3,  3> velocity=<-1,  1>
    position=< 0,  5> velocity=< 0, -1>
    position=<-2,  2> velocity=< 2,  0>
    position=< 5, -2> velocity=< 1,  2>
    position=< 1,  4> velocity=< 2,  1>
    position=<-2,  7> velocity=< 2, -2>
    position=< 3,  6> velocity=<-1, -1>
    position=< 5,  0> velocity=< 1,  0>
    position=<-6,  0> velocity=< 2,  0>
    position=< 5,  9> velocity=< 1, -2>
    position=<14,  7> velocity=<-2,  0>
    position=<-3,  6> velocity=< 2, -1>
    """
  end
end
