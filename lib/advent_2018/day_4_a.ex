defmodule Advent2018.Day4A do
  defstruct guard: nil, sleep_start: nil, log: %{}

  alias Advent2018.Day4A

  def sleepiest_guard_times_minute(input) do
    sleep_report = generate_sleep_report(input)
    sleepy = narcoleptic(sleep_report)
    minute = find_minute(sleep_report, sleepy)

    String.to_integer(sleepy) * minute
  end

  def sleepiest_minute_times_guard(input) do
    sleep_report = generate_sleep_report(input)

    {guard_id, minute_map} =
      sleep_report.log |> Enum.max_by(fn {_key, value} -> Map.values(value) |> Enum.max() end)

    {minute, _} = minute_map |> Enum.max_by(fn {_key, value} -> value end)

    String.to_integer(guard_id) * minute
  end

  defp find_minute(sleep_report, sleepy) do
    {minute, _} = sleep_report.log[sleepy] |> Enum.max_by(fn {_key, value} -> value end)
    minute
  end

  defp narcoleptic(sleep_report) do
    {guard_id, _} =
      sleep_report.log |> Enum.max_by(fn {_key, value} -> Map.values(value) |> Enum.sum() end)

    guard_id
  end

  defp generate_sleep_report(input) do
    input
    |> as_sorted_entries()
    |> process_entries(%Day4A{})
  end

  defp process_entries([head | tail], state) do
    [_, time, event] = String.split(head, ["] ", ":"])
    new_state = record(event, time, state)
    process_entries(tail, new_state)
  end

  defp process_entries(_, state) do
    state
  end

  defp record("Guard #" <> rest, _time, state) do
    [guard_number | _] = String.split(rest, " ")
    %{state | guard: guard_number}
  end

  defp record("falls asleep" <> _rest, time, state) do
    %{state | sleep_start: String.to_integer(time)}
  end

  defp record("wakes up" <> _rest, time, state) do
    end_time = String.to_integer(time) - 1
    range = state.sleep_start..end_time
    default_map = Map.new(range, fn x -> {x, 1} end)
    new_log = Map.update(state.log, state.guard, default_map, &increment_minutes(&1, range))

    %{state | log: new_log, sleep_start: nil}
  end

  defp increment_minutes(map, range) do
    Enum.reduce(range, map, fn each_minute, acc ->
      Map.update(acc, each_minute, 1, &(&1 + 1))
    end)
  end

  defp as_sorted_entries(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.sort()
  end
end
