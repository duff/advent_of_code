defmodule Advent2021.Day06Part2Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day06Part2

  test "fish_count" do
    assert Day06Part2.fish_count(input(), 18) == 26
    assert Day06Part2.fish_count(input(), 80) == 5934
    assert Day06Part2.fish_count(input(), 256) == 26_984_457_539
  end

  test "fish_count real" do
    input = File.read!("test/lib/advent_2021/input/day_06.txt") |> String.trim()
    assert Day06Part2.fish_count(input, 256) == 1_682_576_647_495
  end

  defp input do
    "3,4,3,1,2"
  end
end
