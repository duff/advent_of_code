defmodule Advent2021.Day08BTest do
  use ExUnit.Case, async: true

  alias Advent2021.Day08B

  test "deduce" do
    assert Day08B.deduce("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab") == expected_deduction()
    assert Day08B.deduce("cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab acedgfb") == expected_deduction()
    assert Day08B.deduce("gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab acedgfb cdfbe") == expected_deduction()
    assert Day08B.deduce("fbcad dab cefabd cdfgeb eafb cagedb acedgfb cdfbe gcdfa ab") == expected_deduction()
    assert Day08B.deduce("fbcad dab cefabd cdfgeb eafb cagedb ab acedgfb cdfbe gcdfa") == expected_deduction()
    assert Day08B.deduce("fbcad cefabd cdfgeb eafb cagedb acedgfb cdfbe gcdfa ab dab") == expected_deduction()

    assert Day08B.deduce("gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc") ==
             %{
               2 => MapSet.new('fdbac'),
               6 => MapSet.new('abcdeg'),
               0 => MapSet.new('fegbdc'),
               3 => MapSet.new('gcafb'),
               9 => MapSet.new('cafbge'),
               5 => MapSet.new('ecagb'),
               8 => MapSet.new('dcaebfg'),
               4 => MapSet.new('gaef'),
               7 => MapSet.new('gcf'),
               1 => MapSet.new('gf')
             }

    assert Day08B.deduce("begfcd fabg aecgbdf cefagb edgcba eacbf efgbc bca ab decfa") ==
             %{
               3 => MapSet.new('eacbf'),
               6 => MapSet.new('begfcd'),
               9 => MapSet.new('cefagb'),
               2 => MapSet.new('decfa'),
               5 => MapSet.new('efgbc'),
               8 => MapSet.new('aecgbdf'),
               0 => MapSet.new('edgcba'),
               4 => MapSet.new('fabg'),
               7 => MapSet.new('bca'),
               1 => MapSet.new('ab')
             }
  end

  test "output_value" do
    assert Day08B.output_value("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf") == 5353
  end

  test "sum_output_values" do
    assert Day08B.sum_output_values(input()) == 61229
  end

  test "sum_output_values real" do
    input = File.read!("test/lib/advent_2021/input/day_08.txt")
    assert Day08B.sum_output_values(input) == 974_512
  end

  defp expected_deduction do
    %{
      8 => MapSet.new('acedgfb'),
      5 => MapSet.new('cdfbe'),
      2 => MapSet.new('gcdfa'),
      3 => MapSet.new('fbcad'),
      7 => MapSet.new('dab'),
      9 => MapSet.new('cefabd'),
      6 => MapSet.new('cdfgeb'),
      4 => MapSet.new('eafb'),
      0 => MapSet.new('cagedb'),
      1 => MapSet.new('ab')
    }
  end

  defp input do
    """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """
  end
end
