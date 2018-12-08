defmodule Advent2018.Day4Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day4

  test "sleepiest_guard_times_minute" do
    input = """
    [1518-11-01 00:05] falls asleep
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-01 00:25] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-05 00:45] falls asleep
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-01 00:55] wakes up
    [1518-11-02 00:40] falls asleep
    [1518-11-03 00:24] falls asleep
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-02 00:50] wakes up
    [1518-11-04 00:36] falls asleep
    [1518-11-03 00:29] wakes up
    [1518-11-04 00:46] wakes up
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-05 00:55] wakes up
    """

    assert Day4.sleepiest_guard_times_minute(input) == 240
  end

  test "sleepiest_minute_times_guard" do
    input = """
    [1518-11-01 00:05] falls asleep
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-01 00:25] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-05 00:45] falls asleep
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-01 00:55] wakes up
    [1518-11-02 00:40] falls asleep
    [1518-11-03 00:24] falls asleep
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-02 00:50] wakes up
    [1518-11-04 00:36] falls asleep
    [1518-11-03 00:29] wakes up
    [1518-11-04 00:46] wakes up
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-05 00:55] wakes up
    """

    assert Day4.sleepiest_minute_times_guard(input) == 4455
  end

  @tag :real
  test "sleepiest_guard_times_minute real_deal" do
    input = File.read!("test/lib/advent_2018/input/day4.txt") |> String.trim()
    assert Day4.sleepiest_guard_times_minute(input) == 118_599
  end

  @tag :real
  test "sleepiest_minute_times_guard real_deal" do
    input = File.read!("test/lib/advent_2018/input/day4.txt") |> String.trim()
    assert Day4.sleepiest_minute_times_guard(input) == 33949
  end
end
