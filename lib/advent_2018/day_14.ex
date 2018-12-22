defmodule Advent2018.Day14.Board do
  defstruct scores: %{},
            elf_1: 1,
            elf_2: 2,
            threshold: nil,
            needed_scores: nil,
            total_added: 0,
            expected_pattern: nil,
            last_five: []
end

defmodule Advent2018.Day14 do
  alias Advent2018.Day14.Board

  def part_a(scores, threshold) do
    initialize_a(scores, threshold)
    |> make_hot_chocolate_for_count
    |> final_ten_recipes
  end

  def part_b(scores, expected_pattern) do
    initialize_b(scores, expected_pattern)
    |> make_hot_chocolate_for_pattern
    |> recipe_count_needed
  end

  defp make_hot_chocolate_for_count(%Board{needed_scores: needed, total_added: total_added} = board) when total_added >= needed do
    board
  end

  defp make_hot_chocolate_for_count(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_chocolate_for_count
  end

  defp make_hot_chocolate_for_pattern(%Board{expected_pattern: same, last_five: same} = board) do
    board
  end

  defp make_hot_chocolate_for_pattern(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_chocolate_for_pattern
  end

  defp move_elves(%Board{elf_1: elf_1, elf_2: elf_2} = board) do
    %Board{board | elf_1: new_index(board, elf_1), elf_2: new_index(board, elf_2)}
  end

  defp new_index(%Board{total_added: total_added} = board, current_index) do
    proposed_index = current_index + recipe_at(board, current_index) + 1

    if proposed_index <= total_added do
      proposed_index
    else
      Integer.mod(proposed_index, total_added)
    end
  end

  defp add_recipes(board) do
    sum = elf1_recipe(board) + elf2_recipe(board)
    add_recipes(board, sum)
  end

  defp add_recipes(%Board{scores: scores, total_added: total_added, last_five: last_five} = board, sum) when div(sum, 10) == 0 do
    value = Integer.mod(sum, 10)
    new_last_five = (last_five ++ [value]) |> Enum.take(-5)
    new_scores = Map.put(scores, total_added + 1, value)
    %Board{board | scores: new_scores, total_added: total_added + 1, last_five: new_last_five}
  end

  defp add_recipes(%Board{scores: scores, total_added: total_added, last_five: last_five} = board, sum) do
    value_1 = div(sum, 10)
    value_2 = Integer.mod(sum, 10)
    new_last_five = (last_five ++ [value_1, value_2]) |> Enum.take(-5)

    new_scores =
      scores
      |> Map.put(total_added + 1, div(sum, 10))
      |> Map.put(total_added + 2, Integer.mod(sum, 10))

    %Board{board | scores: new_scores, total_added: total_added + 2, last_five: new_last_five}
  end

  defp final_ten_recipes(%Board{scores: scores, threshold: threshold}) do
    (threshold + 1)..(threshold + 10)
    |> Enum.map(fn each ->
      Map.get(scores, each)
    end)
    |> Enum.join("")
  end

  defp recipe_count_needed(%Board{total_added: total_added}) do
    total_added - 5
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
    %Board{scores: %{1 => uno, 2 => dos}, total_added: 2, expected_pattern: expected, last_five: [uno, dos]}
  end
end
