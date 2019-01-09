defmodule Advent2018.Day20Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day20

  test "part_a" do
    Day20.part_a("^WNE$")

    assert Day20.part_a("^WNE$") == 3
    assert Day20.part_a("^ENWWW(NEEE|SSE(EE|N))$") == 10
    assert Day20.part_a("^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$") == 18
    assert Day20.part_a("^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$") == 23
    assert Day20.part_a("^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$") == 31
  end

  @tag :real
  test "part_a real" do
    input = File.read!("test/lib/advent_2018/input/day_20.txt")
    assert Day20.part_a(input) == 3721
  end
end
