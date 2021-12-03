defmodule Advent2018.Day05Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day05

  test "run_all_reactions" do
    assert Day05.run_all_reactions("dabAcCaCBAcCcaDA") == "dabCBAcaDA"
    assert Day05.run_all_reactions("aA") == ""
    assert Day05.run_all_reactions("abBA") == ""
    assert Day05.run_all_reactions("abAB") == "abAB"
    assert Day05.run_all_reactions("aabAAB") == "aabAAB"
  end

  test "num_units" do
    assert Day05.num_units('dabAcCaCBAcCcaDA') == 10
    assert Day05.num_units('aA') == 0
    assert Day05.num_units('abBA') == 0
    assert Day05.num_units('abAB') == 4
    assert Day05.num_units('aabAAB') == 6
  end

  test "shortest_length" do
    assert Day05.shortest_length("dabAcCaCBAcCcaDA") == 4
  end

  test "num_units for real" do
    input = File.read!("test/lib/advent_2018/input/day_05.txt") |> String.trim() |> String.to_charlist()
    assert Day05.num_units(input) == 9386
  end

  @tag :real_data_slow
  test "shortest_length for real" do
    input = File.read!("test/lib/advent_2018/input/day_05.txt") |> String.trim()
    assert Day05.shortest_length(input) == 4876
  end
end
