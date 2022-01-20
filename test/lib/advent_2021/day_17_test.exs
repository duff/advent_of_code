defmodule Advent2021.Day17Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day17
  alias Advent2021.Day17.Probe

  test "new probe" do
    p = Probe.new(input())
    assert p.min_x == 20
    assert p.max_x == 30
    assert p.min_y == -10
    assert p.max_y == -5
  end

  test "initialize_launch_sequence" do
    p = Probe.new(input())

    p = Probe.initialize_launch_sequence(p, 7, 2)
    assert p.x == 0
    assert p.y == 0
    assert p.velocity_x == 7
    assert p.velocity_y == 2
  end

  test "step" do
    p = Probe.new(input()) |> Probe.initialize_launch_sequence(7, 2)
    p = Probe.step(p)
    assert p.x == 7
    assert p.y == 2
    assert p.velocity_x == 6
    assert p.velocity_y == 1

    p = Probe.step(p)
    assert p.x == 13
    assert p.y == 3
    assert p.velocity_x == 5
    assert p.velocity_y == 0

    p = p |> Probe.step() |> Probe.step() |> Probe.step() |> Probe.step() |> Probe.step() |> Probe.step()
    assert p.velocity_x == 0
  end

  test "launch" do
    p = Probe.new(input())
    assert Probe.launch(p, 7, 2)
    assert Probe.launch(p, 6, 3)
    assert Probe.launch(p, 9, 0)
    assert Probe.launch(p, 6, 9)
    assert Probe.launch(p, 7, 2).x == 28

    refute Probe.launch(p, 17, -4)
  end

  test "highest_y" do
    assert Day17.highest_y(input()) == 45
  end

  test "highest_y real" do
    assert Day17.highest_y("target area: x=138..184, y=-125..-71") == 7750
  end

  defp input do
    "target area: x=20..30, y=-10..-5"
  end
end
