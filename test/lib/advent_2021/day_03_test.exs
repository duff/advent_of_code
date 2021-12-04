defmodule Advent2021.Day03Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day03

  test "power_consumption" do
    assert Day03.power_consumption(input()) == 198
  end

  test "power_consumption real" do
    input = File.read!("test/lib/advent_2021/input/day_03.txt")
    assert Day03.power_consumption(input) == 2261546
  end

  defp input do
    """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """
  end
end
