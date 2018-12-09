defmodule Advent2018.Day7BTest do
  use ExUnit.Case, async: true

  alias Advent2018.Day7B

  test "duration" do
    input = """
    Step C must be finished before step A can begin.
    Step C must be finished before step F can begin.
    Step A must be finished before step B can begin.
    Step A must be finished before step D can begin.
    Step B must be finished before step E can begin.
    Step D must be finished before step E can begin.
    Step F must be finished before step E can begin.
    """

    assert Day7B.duration(input, 2, 64) == 15
  end

  @tag :real
  test "duration real" do
    input = File.read!("test/lib/advent_2018/input/day7.txt") |> String.trim()
    assert Day7B.duration(input, 5, 4) == 1046
  end
end
