defmodule Advent2021.Day06Part1Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day06Part1

  test "increment_day" do
    assert Day06Part1.increment_day([3, 4, 3, 1, 2]) == [2, 3, 2, 0, 1]
    assert Day06Part1.increment_day([2, 3, 2, 0, 1]) == [1, 2, 1, 6, 8, 0]
    assert Day06Part1.increment_day([6, 0, 6, 4, 5, 6, 0, 1, 1, 2, 6, 7, 8, 8, 8]) == [5, 6, 8, 5, 3, 4, 5, 6, 8, 0, 0, 1, 5, 6, 7, 7, 7]
  end

  test "fish_count" do
    assert Day06Part1.fish_count(input(), 18) == 26
    assert Day06Part1.fish_count(input(), 80) == 5934
  end

  test "fish_count real" do
    input = File.read!("test/lib/advent_2021/input/day_06.txt") |> String.trim()
    assert Day06Part1.fish_count(input, 80) == 373_378
  end

  defp input do
    "3,4,3,1,2"
  end
end
