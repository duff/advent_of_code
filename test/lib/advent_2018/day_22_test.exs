defmodule Advent2018.Day22Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day22

  test "part_a" do
    assert Day22.part_a(510, {10, 10}) == 114
  end

  # @tag :real
  # test "part_a real" do
  #   assert Day22.part_a(7863, {14, 760}) == 333
  # end
end
