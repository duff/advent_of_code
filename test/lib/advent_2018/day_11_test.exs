defmodule Advent2018.Day11Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day11

  test "power_level" do
    assert Day11.power_level({3, 5}, 8) == 4
    assert Day11.power_level({122, 79}, 57) == -5
    assert Day11.power_level({217, 196}, 39) == 0
    assert Day11.power_level({101, 153}, 71) == 4
  end

  test "largest_power_grid_of_nine" do
    assert Day11.largest_power_grid_of_nine(18) == {33, 45}
    assert Day11.largest_power_grid_of_nine(42) == {21, 61}
  end

  @tag :real
  test "largest_power_grid_of_nine real" do
    assert Day11.largest_power_grid_of_nine(1309) == {20, 43}
  end
end
