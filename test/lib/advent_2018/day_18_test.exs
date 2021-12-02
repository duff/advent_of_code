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

  @tag :real_data_slow
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_18.txt")
    assert Day18.part_a(input) == 598_416
  end

  @tag :real_data_slow
  test "part_b real" do
    input = File.read!("test/lib/advent_2018/input/day_18.txt")
    assert Day18.part_b(input) == 196_310
  end
end
