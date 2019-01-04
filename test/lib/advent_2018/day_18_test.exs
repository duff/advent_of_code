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
end
