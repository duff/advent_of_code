defmodule Advent2018.Day06Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day06

  test "edges" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert Day06.edges(input) == {1, 9, 1, 8}
  end

  test "board" do
    input = """
    1, 3
    1, 4
    5, 3
    3, 4
    5, 4
    """

    assert Day06.board(input) == [{1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 3}, {3, 4}, {4, 3}, {4, 4}, {5, 3}, {5, 4}]
  end

  test "perimeter" do
    input = """
    1, 5
    1, 4
    5, 3
    3, 4
    5, 4
    """

    assert MapSet.new(Day06.perimeter(input)) ==
             MapSet.new([{1, 4}, {4, 3}, {3, 3}, {1, 3}, {2, 3}, {5, 3}, {5, 4}, {5, 5}, {1, 5}, {2, 5}, {3, 5}, {4, 5}])
  end

  test "min_distances" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    distances = Day06.min_distances(input)
    assert Map.get(distances, {1, 1}) == {{1, 1}, 0}
    assert Map.get(distances, {1, 2}) == {{1, 1}, 1}
    assert Map.get(distances, {1, 9}) == {{1, 6}, 3}
    assert Map.get(distances, {4, 4}) == {{3, 4}, 1}
    assert Map.get(distances, {5, 1}) == {nil, 4}
  end

  test "distance_sums" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    distance_sums = Day06.distance_sums(input)
    assert Map.get(distance_sums, {4, 3}) == 30
  end

  test "desired_region_size" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """

    assert Day06.desired_region_size(input, 32) == 16
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

    assert Day06.largest_finite_area(input) == 17
  end

  @tag :real
  test "largest_finite_area for real" do
    input = File.read!("test/lib/advent_2018/input/day6.txt") |> String.trim()
    assert Day06.largest_finite_area(input) == 4011
  end

  @tag :real
  test "desired_region_size real" do
    input = File.read!("test/lib/advent_2018/input/day6.txt") |> String.trim()
    assert Day06.desired_region_size(input, 10000) == 46054
  end
end
