defmodule Advent2021.Day16ATest do
  use ExUnit.Case, async: true

  alias Advent2021.Day16A

  test "dot_count_after_first_fold" do
    assert Day16A.sum_version_numbers("D2FE28") == 6
    assert Day16A.sum_version_numbers("38006F45291200") == 9
    assert Day16A.sum_version_numbers("EE00D40C823060") == 14

    assert Day16A.sum_version_numbers("8A004A801A8002F478") == 16
    assert Day16A.sum_version_numbers("620080001611562C8802118E34") == 12
    assert Day16A.sum_version_numbers("C0015000016115A2E0802F182340") == 23
    assert Day16A.sum_version_numbers("A0016C880162017C3686B18A3D4780") == 31
  end

  test "dot_count_after_first_fold real" do
    input = File.read!("test/lib/advent_2021/input/day_16.txt") |> String.trim()
    assert Day16A.sum_version_numbers(input) == 993
  end
end
