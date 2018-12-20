defmodule Advent2018.Day13.Railroad do
  defstruct tracks: %{}, trains: %{}, bottom_x: 0, bottom_y: 0, ticks: 0
end

defmodule Advent2018.Day13.Train do
  defstruct x: nil, y: nil, character: nil, next_direction: :left
end

defmodule Advent2018.Day13 do
  alias Advent2018.Day13.Railroad
  alias Advent2018.Day13.Train

  def part_a(input) do
    initialize(input)
    |> IO.inspect(label: "Initialized", limit: 10000)
    |> print()
    |> tick()
    |> print()
    # |> IO.inspect(label: "Initialized", limit: 10000)
  end

  defp tick(railroad) do
    # for x <- 0..railroad.bottom_x,
    #     y <- 0..railroad.bottom_y do
    #   move_train(railroad, Map.get(railroad.trains, {x, y}))
    # end

    Enum.reduce(0..railroad.bottom_x, railroad, fn x, railroad ->
      Enum.reduce(0..railroad.bottom_y, railroad, fn y, railroad ->
        railroad
        # move_train(railroad, Map.get(railroad.trains, {x, y}))
      end)
    end)
  end

  defp move_train(%Railroad{trains: trains} = railroad, %Train{character: ">", x: x, y: y} = train) do
    new_trains =
      trains
      |> Map.delete({x, y})
      |> Map.put({x + 1, y}, %Train{train | x: x + 1})

    %{railroad | trains: new_trains}
  end

  # defp move_train(railroad, nil) do
  #   railroad
  # end

  defp move_train(railroad, _) do
    railroad
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
