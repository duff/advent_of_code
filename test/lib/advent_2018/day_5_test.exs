defmodule Advent2018.Day5Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day5

  test "run_all_reactions" do
    assert Day5.run_all_reactions("dabAcCaCBAcCcaDA") == "dabCBAcaDA"
    assert Day5.run_all_reactions("aA") == ""
    assert Day5.run_all_reactions("abBA") == ""
    assert Day5.run_all_reactions("abAB") == "abAB"
    assert Day5.run_all_reactions("aabAAB") == "aabAAB"
  end

  test "num_units" do
    assert Day5.num_units('dabAcCaCBAcCcaDA') == 10
    assert Day5.num_units('aA') == 0
    assert Day5.num_units('abBA') == 0
    assert Day5.num_units('abAB') == 4
    assert Day5.num_units('aabAAB') == 6
  end

  test "shortest_length" do
    assert Day5.shortest_length("dabAcCaCBAcCcaDA") == 4
  end

  @tag :real
  test "num_units for real" do
    input = File.read!("test/lib/advent_2018/input/day5.txt") |> String.trim() |> String.to_charlist()
    assert Day5.num_units(input) == 9386
  end

  @tag :real
  test "shortest_length for real" do
    input = File.read!("test/lib/advent_2018/input/day5.txt") |> String.trim()
    assert Day5.shortest_length(input) == 4876
  end
end
