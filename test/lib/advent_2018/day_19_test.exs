defmodule Advent2018.Day19Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day19

  test "part_a" do
    input = """
    #ip 0
    seti 5 0 1
    seti 6 0 2
    addi 0 1 0
    addr 1 2 3
    setr 1 0 0
    seti 8 0 4
    seti 9 0 5
    """

    Day19.part_a(input)
  end

  test "addi" do
    # assert Day19.execute([:addi, 2, 1, 2], [3, 2, 1, 1, 0, 0]) == [3, 2, 2, 1, 0, 0]
  end
end
