defmodule Advent2018.Day8ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day8A

  test "metadata_sum" do
    input = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
    assert Day8A.metadata_sum(input) == 138
  end

  @tag :real
  test "metadata_sum real" do
    input = File.read!("test/lib/advent_2018/input/day8.txt") |> String.trim()
    assert Day8A.metadata_sum(input) == 38449
  end
end
