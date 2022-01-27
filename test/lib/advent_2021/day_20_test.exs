defmodule Advent2021.Day20Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day20

  test "part_one" do
    assert Day20.part_one(input()) == 35
  end

  test "part_one real" do
    input = File.read!("test/lib/advent_2021/input/day_20.txt") |> String.trim()
    assert Day20.part_one(input) == 5461
  end

  @tag :real_data_slow
  test "part_two" do
    assert Day20.part_two(input()) == 3351
  end

  @tag :real_data_slow
  test "part_two real" do
    input = File.read!("test/lib/advent_2021/input/day_20.txt") |> String.trim()
    assert Day20.part_two(input) == 18226
  end


  defp input do
    """
    ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#


    #..#.
    #....
    ##..#
    ..#..
    ..###
    """
  end
end
