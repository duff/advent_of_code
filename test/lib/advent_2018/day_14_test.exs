defmodule Advent2018.Day14Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day14

  test "part_a" do
    assert Day14.part_a([3, 7], 9) == "5158916779"
    assert Day14.part_a([3, 7], 5) == "0124515891"
    assert Day14.part_a([3, 7], 18) == "9251071085"
    assert Day14.part_a([3, 7], 2018) == "5941429882"
  end

  test "part_b" do
    assert Day14.part_b([3, 7], "515891") == 9
    assert Day14.part_b([3, 7], "012451") == 5
    assert Day14.part_b([3, 7], "925107") == 18
    assert Day14.part_b([3, 7], "594142") == 2018
  end

  @tag :real
  test "part_a real" do
    assert Day14.part_a([3, 7], 554_401) == "3610281143"
  end

  @tag :real
  test "part_b real" do
    assert Day14.part_b([3, 7], "554401") == 20_211_326
  end
end
