defmodule Advent2021.Day02Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day02

  test "horizontal_depth_product" do
    assert Day02.horizontal_depth_product(input()) == 150
  end

  test "horizontal_depth_product_with_aim" do
    assert Day02.horizontal_depth_product_with_aim(input()) == 900
  end

  test "horizontal_depth_product real" do
    input = File.read!("test/lib/advent_2021/input/day_02.txt")
    assert Day02.horizontal_depth_product(input) == 1_459_206
  end

  test "horizontal_depth_product_with_aim real" do
    input = File.read!("test/lib/advent_2021/input/day_02.txt")
    assert Day02.horizontal_depth_product_with_aim(input) == 1_320_534_480
  end

  defp input do
    """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """
  end
end
