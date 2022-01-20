defmodule Advent2021.Day17.Probe do
  alias Advent2021.Day17.Probe

  defstruct ~w(min_x max_x min_y max_y x y velocity_x velocity_y highest_y)a

  def new(input) do
    [a, b, c, d] = int_parts(input)
    %Probe{min_x: a, max_x: b, min_y: c, max_y: d}
  end

  def initialize_launch_sequence(probe, velocity_x, velocity_y) do
    %{probe | velocity_x: velocity_x, velocity_y: velocity_y, x: 0, y: 0, highest_y: 0}
  end

  def in_target_area(p) do
    p.x in p.min_x..p.max_x && p.y in p.min_y..p.max_y
  end

  def step(p) do
    {new_x, new_y} = {p.x + p.velocity_x, p.y + p.velocity_y}
    %{p | velocity_x: new_velocity_x(p), velocity_y: p.velocity_y - 1, x: new_x, y: new_y, highest_y: max(p.highest_y, new_y)}
  end

  def launch(p, initial_x_velocity, initial_y_velocity) do
    p = Probe.initialize_launch_sequence(p, initial_x_velocity, initial_y_velocity)

    Enum.reduce_while(1..1000, p, fn _, acc ->
      p = Probe.step(acc)

      if Probe.in_target_area(p) do
        {:halt, p}
      else
        if p.x > p.max_x or p.y < p.min_y do
          {:halt, false}
        else
          {:cont, p}
        end
      end
    end)
  end

  defp new_velocity_x(%Probe{velocity_x: 0}), do: 0
  defp new_velocity_x(%Probe{velocity_x: velocity_x}), do: velocity_x - 1

  defp int_parts("target area: x=" <> rest) do
    rest
    |> String.split([",", "..", " y="], trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule Advent2021.Day17 do
  alias Advent2021.Day17.Probe

  def highest_y(input) do
    p = Probe.new(input)

    for velocity_x <- 0..150,
        velocity_y <- 0..150,
        p = Probe.launch(p, velocity_x, velocity_y) do
      p.highest_y
    end
    |> Enum.max()
  end

  def velocity_count(input) do
    p = Probe.new(input)

    for velocity_x <- 0..200,
        velocity_y <- -200..200,
        p = Probe.launch(p, velocity_x, velocity_y) do
      p
    end
    |> Enum.count()
  end
end
