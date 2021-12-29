defmodule Advent2021.Day07Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day07

  test "minimum_fuel" do
    assert Day07.minimum_fuel(input()) == 37
  end

  test "minimum_fuel real" do
    input = File.read!("test/lib/advent_2021/input/day_07.txt") |> String.trim()
    assert Day07.minimum_fuel(input) == 328_262
  end

  defp input do
    "16,1,2,0,4,2,7,1,2,14"
  end
end
