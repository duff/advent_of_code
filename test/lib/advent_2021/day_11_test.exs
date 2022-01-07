defmodule Advent2021.Day11Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day11

  test "flashes" do
    assert Day11.flashes(input()) == 1656
  end

  test "flashes real" do
    assert Day11.flashes(real_input()) == 1723
  end

  defp input do
    """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """
  end

  defp real_input do
    """
    2238518614
    4552388553
    2562121143
    2666685337
    7575518784
    3572534871
    8411718283
    7742668385
    1235133231
    2546165345
    """
  end
end
