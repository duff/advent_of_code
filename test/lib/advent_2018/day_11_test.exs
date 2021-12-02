defmodule Advent2018.Day11Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day11

  test "power_level" do
    assert Day11.power_level({3, 5}, 8) == 4
    assert Day11.power_level({122, 79}, 57) == -5
    assert Day11.power_level({217, 196}, 39) == 0
    assert Day11.power_level({101, 153}, 71) == 4
  end

  test "summed_area_table_2" do
    input = %{
      {1, 1} => 31,
      {1, 2} => 12,
      {1, 3} => 13,
      {1, 4} => 24,
      {1, 5} => 30,
      {2, 1} => 2,
      {2, 2} => 26,
      {2, 3} => 17,
      {2, 4} => 23,
      {2, 5} => 8,
      {3, 1} => 4,
      {3, 2} => 9,
      {3, 3} => 21,
      {3, 4} => 15,
      {3, 5} => 28,
      {4, 1} => 33,
      {4, 2} => 10,
      {4, 3} => 22,
      {4, 4} => 16,
      {4, 5} => 27,
      {5, 1} => 5,
      {5, 2} => 29,
      {5, 3} => 20,
      {5, 4} => 14,
      {5, 5} => 11
    }

    assert Day11.summed_area_table(5, input) ==
             %{
               {1, 1} => 31,
               {1, 2} => 43,
               {1, 3} => 56,
               {1, 4} => 80,
               {1, 5} => 110,
               {2, 1} => 33,
               {2, 2} => 71,
               {2, 3} => 101,
               {2, 4} => 148,
               {2, 5} => 186,
               {3, 1} => 37,
               {3, 2} => 84,
               {3, 3} => 135,
               {3, 4} => 197,
               {3, 5} => 263,
               {4, 1} => 70,
               {4, 2} => 127,
               {4, 3} => 200,
               {4, 4} => 278,
               {4, 5} => 371,
               {5, 1} => 75,
               {5, 2} => 161,
               {5, 3} => 254,
               {5, 4} => 346,
               {5, 5} => 450
             }
  end

  @tag :real_data_slow
  test "part_a real" do
    assert Day11.part_a(18) == {33, 45}
    assert Day11.part_a(42) == {21, 61}
    assert Day11.part_a(1309) == {20, 43}
  end

  @tag :real_data_slow
  test "largest_power_grid real" do
    assert Day11.part_b(18) == {90, 269, 16}
    assert Day11.part_b(42) == {232, 251, 12}
    assert Day11.part_b(1309) == {233, 271, 13}
  end
end
