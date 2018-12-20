defmodule Advent2018.Day13.Railroad do
  defstruct tracks: %{}, trains: %{}, bottom_right: {0, 0}
end

defmodule Advent2018.Day13.Train do
  defstruct character: nil, next_direction: :left
end

defmodule Advent2018.Day13 do
  alias Advent2018.Day13.Railroad
  alias Advent2018.Day13.Train

  def part_a(input) do
    initialize(input)
    |> IO.inspect(label: "Initialized", limit: 10000)
    |> print()
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

  defp put_train(%Railroad{trains: trains} = railroad, coordinates, character) do
    %{railroad | trains: Map.put(trains, coordinates, %Train{character: character})}
  end

  defp update_bottom_right(%Railroad{bottom_right: {x, y}} = railroad, {new_x, new_y}) do
    %{railroad | bottom_right: {max(x, new_x), max(y, new_y)}}
  end

  defp print(railroad) do
    railroad
    |> display_string()
    |> IO.puts()

    railroad
  end

  defp display_string(%Railroad{bottom_right: {_, bottom_y}} = railroad) do
    Enum.reduce(0..bottom_y, [], fn y, rows ->
      rows ++ [row_string(railroad, y)]
    end)
    |> Enum.join("\n")
  end

  defp row_string(%Railroad{bottom_right: {bottom_x, _}} = railroad, y) do
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
