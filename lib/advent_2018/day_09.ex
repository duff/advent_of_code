defmodule Advent2018.Day09.Game do
  defstruct marbles: [0],
            current_marble_index: 0,
            current_player: 1,
            player_count: nil,
            last_marble_index: nil,
            next_marble: 1,
            scores: %{}
end

defmodule Advent2018.Day09 do
  alias Advent2018.Day09.Game

  def score(player_count, last_marble_played) do
    initialize_game(player_count, last_marble_played)
    |> play
    |> find_high_score
  end

  defp play(%Game{next_marble: same, last_marble_index: same} = game) do
    game
  end

  defp play(game) do
    game
    |> insert_next_marble
    |> increment_next_marble
    |> increment_current_player
    |> play
  end

  defp insert_next_marble(%Game{next_marble: next_marble} = game) when rem(next_marble, 23) == 0 do
    bonus_index = bonus_marble_index(game)
    {bonus_marble, marbles} = List.pop_at(game.marbles, bonus_index)

    added_to_score = game.next_marble + bonus_marble
    new_score = Map.update(game.scores, game.current_player, added_to_score, &(&1 + added_to_score))

    %{game | scores: new_score, marbles: marbles, current_marble_index: bonus_index}
  end

  defp insert_next_marble(game) do
    new_index = new_index(game)
    marbles = List.insert_at(game.marbles, new_index, game.next_marble)
    %{game | marbles: marbles, current_marble_index: new_index}
  end

  defp bonus_marble_index(%Game{current_marble_index: current}) do
    -(7 - current)
  end

  defp new_index(%Game{current_marble_index: current, marbles: marbles}) when current == length(marbles) - 1 do
    1
  end

  defp new_index(%Game{current_marble_index: current}) do
    current + 2
  end

  defp increment_next_marble(%Game{next_marble: next_marble} = game) do
    %{game | next_marble: next_marble + 1}
  end

  defp increment_current_player(%Game{current_player: same, player_count: same} = game) do
    %{game | current_player: 1}
  end

  defp increment_current_player(%Game{current_player: current_player} = game) do
    %{game | current_player: current_player + 1}
  end

  defp initialize_game(player_count, last_marble_played) do
    %Game{player_count: player_count, last_marble_index: last_marble_played + 1}
  end

  defp find_high_score(%Game{scores: scores}) do
    {_player, score} = Enum.max_by(scores, fn {_key, value} -> value end)
    score
  end
end
