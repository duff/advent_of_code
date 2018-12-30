defmodule Advent2018.Day16Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day16

  test "addi" do
    assert Day16.execute(:addi, [2, 1, 2], [3, 2, 1, 1]) == [3, 2, 2, 1]
  end

  test "addr" do
    assert Day16.execute(:addr, [2, 1, 2], [3, 2, 1, 1]) == [3, 2, 3, 1]
  end

  test "mulr" do
    assert Day16.execute(:mulr, [2, 1, 2], [3, 2, 1, 1]) == [3, 2, 2, 1]
  end

  test "muli" do
    assert Day16.execute(:muli, [0, 2, 2], [3, 2, 1, 1]) == [3, 2, 6, 1]
  end

  test "seti" do
    assert Day16.execute(:seti, [2, 1, 2], [3, 2, 1, 1]) == [3, 2, 2, 1]
  end

  test "opcode_count_for_sample" do
    input = [
      "Before: [3, 2, 1, 1]",
      "9 2 1 2",
      "After:  [3, 2, 2, 1]"
    ]

    assert Day16.opcode_count_for_sample(input) == 3
  end

  test "opcodes_for_sample" do
    input = [
      "Before: [3, 2, 1, 1]",
      "9 2 1 2",
      "After:  [3, 2, 2, 1]"
    ]

    assert Day16.opcodes_for_sample(input) == {9, ~w[addi mulr seti]a}
  end

  @tag :real
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_16_a.txt")
    assert Day16.part_a(input) == 544
  end

  @tag :real
  test "part_b real" do
    input_samples = File.read!("test/lib/advent_2018/input/day_16_a.txt")
    input_program = File.read!("test/lib/advent_2018/input/day_16_b.txt")
    assert Day16.part_b(input_samples, input_program) == 600
  end
end
