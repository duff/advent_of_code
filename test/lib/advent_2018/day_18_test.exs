defmodule Advent2018.Day18Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day18

  test "part_a" do
    input = """
    .#.#...|#.
    .....#|##|
    .|..|...#.
    ..|#.....#
    #.#|||#|#|
    ...#.||...
    .|....|...
    ||...#|.#|
    |.||||..|.
    ...#.|..|.
    """

    assert Day18.part_a(input) == 1147
  end

  @tag :real
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_18.txt")
    assert Day18.part_a(input) == 598_416
  end
end
