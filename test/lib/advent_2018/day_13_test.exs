defmodule Advent2018.Day13Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day13

  # test "part_a simplest track" do
  #   input = """
  #   |
  #   v
  #   |
  #   |
  #   |
  #   ^
  #   |
  #   """

  #   Day13.part_a(input)
  #   # assert Day13.part_a(input) == {0, 3}
  # end

  test "part_a larger track" do
    input = ~S"""
    /->-\
    |   |  /----\
    | /-+--+-\  |
    | | |  | v  |
    \-+-/  \-+--/
      \------/
    """

    Day13.part_a(input)
    # assert Day13.part_a(input) == {7, 3}
  end
end
