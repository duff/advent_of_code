defmodule Advent2018.Day6Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day6

  test "edges" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert Day6.edges(input) == {1, 9, 1, 8}
  end

  test "board" do
    input = """
    1, 3
    1, 4
    5, 3
    3, 4
    5, 4
    """

    assert Day6.board(input) == [{1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 3}, {3, 4}, {4, 3}, {4, 4}, {5, 3}, {5, 4}]
  end

  test "distances" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    distances = Day6.distances(input)
    assert Map.get(distances, {1, 1}) == { {1, 1}, 0 }
    assert Map.get(distances, {1, 2}) == { {1, 1}, 1 }
    assert Map.get(distances, {1, 9}) == { {1, 6}, 3 }
    assert Map.get(distances, {4, 4}) == { {3, 4}, 1 }
    assert Map.get(distances, {5, 1}) == { nil, 4 }
  end

  test "largest_finite_area" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert Day6.largest_finite_area(input) == 17
  end

  @tag :real
  test "largest_finite_area for real" do
    input = File.read!("test/lib/advent_2018/input/day6.txt") |> String.trim()
    assert Day6.largest_finite_area(input) == 6825
  end
end
