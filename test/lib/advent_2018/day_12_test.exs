defmodule Advent2018.Day12Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day12

  test "part_a" do
    initial_state = "#..#.#..##......###...###"

    notes = """
    ...## => #
    ..#.. => #
    .#... => #
    .#.#. => #
    .#.## => #
    .##.. => #
    .#### => #
    #.#.# => #
    #.### => #
    ##.#. => #
    ##.## => #
    ###.. => #
    ###.# => #
    ####. => #
    """

    assert Day12.part_a(initial_state, notes) == 44
  end
end
