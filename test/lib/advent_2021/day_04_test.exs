defmodule Advent2021.Day04Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day04
  alias Advent2021.Day04.Board

  test "mark" do
    board =
      Board.new([
        [14, 21, 17, 24, 4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 21, 20],
        [22, 11, 13, 6, 5],
        [2, 0, 12, 3, 21]
      ])

    assert Board.mark(board, 21).marks == MapSet.new([{0, 1}, {2, 3}, {4, 4}])
    assert Board.mark(board, 10).marks == MapSet.new([{1, 0}])
  end

  test "won?" do
    assert Board.won?(%Board{marks: MapSet.new([{4, 0}, {4, 1}, {4, 2}, {4, 3}, {4, 4}])})
    assert !Board.won?(%Board{marks: MapSet.new([{0, 0}, {0, 1}, {0, 2}, {0, 3}])})
    assert Board.won?(%Board{marks: MapSet.new([{0, 3}, {1, 3}, {2, 3}, {3, 3}, {4, 3}])})
  end

  test "unmarked_number_sum" do
    board =
      Board.new([
        [1, 21, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 21, 0],
        [0, 0, 10, 0, 0],
        [2, 0, 0, 0, 0]
      ])

    assert Board.unmarked_number_sum(Board.mark(board, 21)) == 13
    assert Board.unmarked_number_sum(Board.mark(board, 10)) == 45
  end

  test "score" do
    assert Day04.score(input()) == 4512
  end

  test "score_real" do
    input = File.read!("test/lib/advent_2021/input/day_04.txt")
    assert Day04.score(input) == 2745
  end

  defp input do
    """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
    """
  end
end
