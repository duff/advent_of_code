defmodule Advent2018.Day14.Board do
  defstruct scores: %{}, elf_1: 1, elf_2: 2, threshold: nil, needed_scores: nil, total_added: 0
end

defmodule Advent2018.Day14 do
  alias Advent2018.Day14.Board

  def part_a(scores, threshold) do
    initialize(scores, threshold)
    |> make_hot_chocolate
    |> final_ten_recipes
  end

  defp make_hot_chocolate(%Board{needed_scores: needed, total_added: total_added} = board) when total_added >= needed do
    board
  end

  defp make_hot_chocolate(board) do
    board
    |> add_recipes
    |> move_elves
    |> make_hot_chocolate
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

  defp add_recipes(%Board{scores: scores, total_added: total_added} = board, sum) when div(sum, 10) == 0 do
    new_scores = Map.put(scores, total_added + 1, Integer.mod(sum, 10))
    %Board{board | scores: new_scores, total_added: total_added + 1}
  end

  defp add_recipes(%Board{scores: scores, total_added: total_added} = board, sum) do
    new_scores =
      scores
      |> Map.put(total_added + 1, div(sum, 10))
      |> Map.put(total_added + 2, Integer.mod(sum, 10))

    %Board{board | scores: new_scores, total_added: total_added + 2}
  end

  defp final_ten_recipes(%Board{scores: scores, threshold: threshold}) do
    (threshold + 1)..(threshold + 10)
    |> Enum.map(fn each ->
      Map.get(scores, each)
    end)
    |> Enum.join("")
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

  defp initialize([uno, dos], threshold) do
    %Board{scores: %{1 => uno, 2 => dos}, total_added: 2, threshold: threshold, needed_scores: threshold + 10}
  end
end
