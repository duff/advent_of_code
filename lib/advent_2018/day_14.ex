defmodule Advent2018.Day14.Board do
  defstruct scores: [], elf_1: 0, elf_2: 1, threshold: nil, needed_scores: nil
end

defmodule Advent2018.Day14 do
  alias Advent2018.Day14.Board

  def part_a(scores, threshold) do
    initialize(scores, threshold)
    |> make_hot_chocolate
    |> final_ten_recipes
  end

  defp make_hot_chocolate(%Board{scores: scores, needed_scores: needed} = board) when length(scores) >= needed do
    board
  end

  defp make_hot_chocolate(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_chocolate
  end

  defp move_elves(%Board{elf_1: elf_1, elf_2: elf_2, scores: scores} = board) do
    %Board{board | elf_1: new_index(board, elf_1), elf_2: new_index(board, elf_2)}
  end

  defp new_index(%Board{scores: scores} = board, current_index) do
    proposed_index = current_index + recipe_at(board, current_index) + 1

    if proposed_index < length(scores) do
      proposed_index
    else
      Integer.mod(proposed_index, length(scores))
    end
  end

  defp add_recipes(board) do
    sum = elf1_recipe(board) + elf2_recipe(board)
    %Board{board | scores: board.scores ++ new_recipes(sum)}
  end

  defp new_recipes(sum) when div(sum, 10) == 0 do
    [Integer.mod(sum, 10)]
  end

  defp new_recipes(sum) do
    [div(sum, 10), Integer.mod(sum, 10)]
  end

  defp final_ten_recipes(%Board{scores: scores, threshold: threshold}) do
    scores
    |> Enum.split(threshold)
    |> elem(1)
    |> Enum.take(10)
    |> Enum.join("")
  end

  defp recipe_at(board, index) do
    Enum.at(board.scores, index)
  end

  defp elf1_recipe(board) do
    recipe_at(board, board.elf_1)
  end

  defp elf2_recipe(board) do
    recipe_at(board, board.elf_2)
  end

  defp initialize(scores, threshold) do
    %Board{scores: scores, threshold: threshold, needed_scores: threshold + 10}
  end
end
