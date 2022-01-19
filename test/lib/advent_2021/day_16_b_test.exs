defmodule Advent2021.Day16BTest do
  use ExUnit.Case, async: true

  alias Advent2021.Day16B

  test "dot_count_after_first_fold" do
    assert Day16B.sum_version_numbers("D2FE28") == 6
    assert Day16B.sum_version_numbers("38006F45291200") == 9
    assert Day16B.sum_version_numbers("EE00D40C823060") == 14

    assert Day16B.sum_version_numbers("8A004A801A8002F478") == 16
    assert Day16B.sum_version_numbers("620080001611562C8802118E34") == 12
    assert Day16B.sum_version_numbers("C0015000016115A2E0802F182340") == 23
    assert Day16B.sum_version_numbers("A0016C880162017C3686B18A3D4780") == 31
  end

  test "dot_count_after_first_fold real" do
    input = File.read!("test/lib/advent_2021/input/day_16.txt") |> String.trim()
    assert Day16B.sum_version_numbers(input) == 993
  end

  test "value" do
    assert Day16B.value("C200B40A82") == 3
    assert Day16B.value("04005AC33890") == 54
    assert Day16B.value("880086C3E88112") == 7
    assert Day16B.value("CE00C43D881120") == 9
    assert Day16B.value("D8005AC2A8F0") == 1
    assert Day16B.value("F600BC2D8F") == 0
    assert Day16B.value("9C005AC2F8F0") == 0
    assert Day16B.value("9C0141080250320F1802104A08") == 1
  end

  test "value real" do
    input = File.read!("test/lib/advent_2021/input/day_16.txt") |> String.trim()
    assert Day16B.value(input) == 144_595_909_277
  end
end
