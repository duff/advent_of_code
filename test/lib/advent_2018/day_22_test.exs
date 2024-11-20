defmodule Advent2018.Day22Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day22

  test "part_a" do
    assert Day22.part_a(510, {10, 10}) == 114
  end

  test "part_b" do
    assert Day22.part_b(510, {10, 10}) == 45
    Day22.part_b(510, {10, 10})
  end

  @tag :real_data_slow
  test "part_a real" do
    assert Day22.part_a(7863, {14, 760}) == 11462
  end

  @tag :real_data_really_slow
  test "part_b real" do
    assert Day22.part_b(7863, {14, 760}) == 1054
  end
end
