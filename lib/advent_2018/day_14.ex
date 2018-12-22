defmodule Advent2018.Day14.Board do
  defstruct scores: %{},
            elf_1: 1,
            elf_2: 2,
            threshold: nil,
            needed_scores: nil,
            total_added: 0,
            expected_pattern: nil,
            last_received: []
end

defmodule Advent2018.Day14 do
  alias Advent2018.Day14.Board

  @remember_count 8

  def part_a(scores, threshold) do
    initialize_a(scores, threshold)
    |> make_hot_cocoa_for_count
    |> final_ten_recipes
  end

  def part_b(scores, expected_pattern) do
    initialize_b(scores, expected_pattern)
    |> make_hot_cocoa_for_pattern
    |> recipe_count_needed
  end

  defp make_hot_cocoa_for_count(%Board{needed_scores: needed, total_added: total_added} = board) when total_added >= needed do
    board
  end

  defp make_hot_cocoa_for_count(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_cocoa_for_count
  end

  defp make_hot_cocoa_for_pattern(%Board{expected_pattern: [a, b, c, d, e, f | _], last_received: [a, b, c, d, e, f | _]} = board) do
    board
  end

  defp make_hot_cocoa_for_pattern(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_cocoa_for_pattern
  end

  defp move_elves(%Board{elf_1: elf_1, elf_2: elf_2} = board) do
    %Board{board | elf_1: new_index(board, elf_1), elf_2: new_index(board, elf_2)}
  end

  defp new_index(%Board{total_added: total_added} = board, current_index) do
    proposed_index = current_index + recipe_at(board, current_index) + 1

    if proposed_index <= total_added do
      proposed_index
    else
      rem(proposed_index, total_added)
    end
  end

  defp add_recipes(board) do
    sum = elf1_recipe(board) + elf2_recipe(board)
    add_recipes(board, sum)
  end

  defp add_recipes(%Board{total_added: total_added, last_received: last_received} = board, sum) when div(sum, 10) == 0 do
    value = rem(sum, 10)
    new_last_received = (last_received ++ [value]) |> Enum.take(-@remember_count)
    new_scores = Map.put(board.scores, total_added + 1, value)

    %Board{board | scores: new_scores, total_added: total_added + 1, last_received: new_last_received}
  end

  defp add_recipes(%Board{total_added: total_added, last_received: last_received} = board, sum) do
    value_1 = div(sum, 10)
    value_2 = rem(sum, 10)
    new_last_received = (last_received ++ [value_1, value_2]) |> Enum.take(-@remember_count)

    new_scores =
      board.scores
      |> Map.put(total_added + 1, value_1)
      |> Map.put(total_added + 2, value_2)

    %Board{board | scores: new_scores, total_added: total_added + 2, last_received: new_last_received}
  end

  defp final_ten_recipes(%Board{scores: scores, threshold: threshold}) do
    (threshold + 1)..(threshold + 10)
    |> Enum.map(&Map.get(scores, &1))
    |> Enum.join("")
  end

  defp recipe_count_needed(%Board{total_added: total_added}) do
    total_added - @remember_count
  end

  defp recipe_at(board, index) do
    Map.get(board.scores, index)
  end

  defp elf1_recipe(board) do
    recipe_at(board, board.elf_1)
  end

  defp elf2_recipe(board) do
    recipe_at(board, board.elf_2)
  end

  defp initialize_a([uno, dos], threshold) do
    %Board{scores: %{1 => uno, 2 => dos}, total_added: 2, threshold: threshold, needed_scores: threshold + 10}
  end

  defp initialize_b([uno, dos], expected_pattern) do
    expected = String.split(expected_pattern, "", trim: true) |> Enum.map(&String.to_integer/1)
    %Board{scores: %{1 => uno, 2 => dos}, total_added: 2, expected_pattern: expected, last_received: [uno, dos]}
  end
end
