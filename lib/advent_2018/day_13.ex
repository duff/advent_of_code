defmodule Advent2018.Day13.Railroad do
  defstruct tracks: %{}, trains: %{}, bottom_x: 0, bottom_y: 0, ticks: 0, first_collision_at: nil
end

defmodule Advent2018.Day13.Train do
  defstruct x: nil, y: nil, character: nil, next_direction: :left, moved_this_tick: false
end

defmodule Advent2018.Day13 do
  alias Advent2018.Day13.Railroad
  alias Advent2018.Day13.Train

  def part_a(input) do
    initialize(input)
    |> print()
    |> tick()
  end

  defp tick(%Railroad{first_collision_at: nil} = railroad) do
    Enum.reduce(0..railroad.bottom_x, railroad, fn x, railroad ->
      Enum.reduce(0..railroad.bottom_y, railroad, fn y, railroad ->
        move_train(railroad, {x, y})
      end)
    end)
    |> preprare_for_next_tick()
    |> print()
    |> tick()
  end

  defp tick(%Railroad{first_collision_at: position}) do
    position
  end

  defp move_train(railroad, coordinates) do
    case new_train_position(train_at(railroad, coordinates)) do
      {:ok, new_position, train} ->
        railroad
        |> check_for_collision(new_position)
        |> actually_move_train(new_position, train)

      :no_train ->
        railroad
    end
  end

  defp check_for_collision(%Railroad{first_collision_at: nil} = railroad, new_position) do
    if train_at(railroad, new_position) do
      %{railroad | first_collision_at: new_position}
    else
      railroad
    end
  end

  defp check_for_collision(railroad, _new_position) do
    railroad
  end

  defp new_train_position(%Train{character: ">", x: x, y: y, moved_this_tick: false} = train) do
    {:ok, {x + 1, y}, train}
  end

  defp new_train_position(%Train{character: "<", x: x, y: y, moved_this_tick: false} = train) do
    {:ok, {x - 1, y}, train}
  end

  defp new_train_position(%Train{character: "v", x: x, y: y, moved_this_tick: false} = train) do
    {:ok, {x, y + 1}, train}
  end

  defp new_train_position(%Train{character: "^", x: x, y: y, moved_this_tick: false} = train) do
    {:ok, {x, y - 1}, train}
  end

  defp new_train_position(_) do
    :no_train
  end

  defp actually_move_train(%Railroad{trains: trains} = railroad, {new_x, new_y}, %Train{x: old_x, y: old_y} = train) do
    new_trains =
      trains
      |> Map.delete({old_x, old_y})
      |> Map.put({new_x, new_y}, %Train{train | x: new_x, y: new_y, moved_this_tick: true})

    %{railroad | trains: new_trains}
  end

  defp preprare_for_next_tick(%Railroad{trains: trains} = railroad) do
    new_trains =
      trains
      |> Enum.map(fn {coordinates, train} -> {coordinates, %Train{train | moved_this_tick: false}} end)
      |> Map.new()

    %{railroad | trains: new_trains}
  end

  # Next steps:
  #   * Handle moving to an intersection.
  #   * Handle moving to a curve.

  defp train_at(railroad, coordinates) do
    Map.get(railroad.trains, coordinates)
  end

  defp put_track_and_train(railroad, coordinates, char) when char in [">", "<"] do
    railroad
    |> put_track(coordinates, "-")
    |> put_train(coordinates, char)
  end

  defp put_track_and_train(railroad, coordinates, char) when char in ["v", "^"] do
    railroad
    |> put_track(coordinates, "|")
    |> put_train(coordinates, char)
  end

  defp put_track_and_train(railroad, coordinates, character) do
    put_track(railroad, coordinates, character)
  end

  defp put_track(%Railroad{tracks: tracks} = railroad, coordinates, character) do
    %{railroad | tracks: Map.put(tracks, coordinates, character)}
  end

  defp put_train(%Railroad{trains: trains} = railroad, {x, y}, character) do
    %{railroad | trains: Map.put(trains, {x, y}, %Train{x: x, y: y, character: character})}
  end

  defp update_bottom_right(%Railroad{bottom_x: x, bottom_y: y} = railroad, {new_x, new_y}) do
    %{railroad | bottom_x: max(x, new_x), bottom_y: max(y, new_y)}
  end

  defp initialize(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%Railroad{}, fn {row, y}, railroad ->
      String.codepoints(row)
      |> Enum.with_index()
      |> Enum.reduce(railroad, fn {character, x}, railroad ->
        railroad
        |> put_track_and_train({x, y}, character)
        |> update_bottom_right({x, y})
      end)
    end)
  end

  defp print(railroad) do
    IO.puts("")

    railroad
    |> display_string()
    |> IO.puts()

    IO.puts("")

    railroad
  end

  defp display_string(%Railroad{bottom_y: bottom_y} = railroad) do
    Enum.reduce(0..bottom_y, [], fn y, rows ->
      rows ++ [row_string(railroad, y)]
    end)
    |> Enum.join("\n")
  end

  defp row_string(%Railroad{bottom_x: bottom_x} = railroad, y) do
    Enum.reduce(0..bottom_x, "", fn x, row ->
      row <> display_character(railroad, x, y)
    end)
  end

  defp display_character(%Railroad{trains: trains, tracks: tracks}, x, y) do
    case Map.get(trains, {x, y}) do
      %Train{character: character} -> character
      _ -> Map.get(tracks, {x, y}, " ")
    end
  end
end
