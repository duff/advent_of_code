defmodule Advent2021.Day04.Board do
  alias Advent2021.Day04.Board

  defstruct [:grid, :marks]

  def new(grid) do
    %Board{grid: grid, marks: MapSet.new()}
  end

  def mark(board, number) do
    for x <- 0..4, y <- 0..4, reduce: board do
      acc -> update_marks(acc, x, y, number)
    end
  end

  def won?(%Board{marks: marks}) do
    row_victory?(marks) or column_victory?(marks)
  end

  def unmarked_number_sum(board = %Board{marks: marks}) do
    for x <- 0..4, y <- 0..4 do
      if MapSet.member?(marks, {x, y}) do
        0
      else
        element(board, x, y)
      end
    end
    |> Enum.sum()
  end

  defp row_victory?(marks) do
    Enum.any?(0..4, fn x ->
      Enum.all?(0..4, fn y ->
        MapSet.member?(marks, {x, y})
      end)
    end)
  end

  defp column_victory?(marks) do
    Enum.any?(0..4, fn y ->
      Enum.all?(0..4, fn x ->
        MapSet.member?(marks, {x, y})
      end)
    end)
  end

  defp update_marks(board, x, y, number) do
    if matched?(board, x, y, number) do
      %{board | marks: MapSet.put(board.marks, {x, y})}
    else
      board
    end
  end

  defp matched?(board, x, y, number) do
    element(board, x, y) == number
  end

  defp element(%Board{grid: grid}, x, y) do
    grid
    |> Enum.at(x)
    |> Enum.at(y)
  end
end

defmodule Advent2021.Day04 do
  alias Advent2021.Day04.Board

  def score_first_winning(input) do
    {drawn_numbers, boards} = parse(input)

    {number_triggering_winner, winning_board} =
      Enum.reduce_while(drawn_numbers, boards, fn number, acc ->
        marked = Enum.map(acc, fn board -> Board.mark(board, number) end)
        won = Enum.find(marked, &Board.won?/1)

        if won do
          {:halt, {number, won}}
        else
          {:cont, marked}
        end
      end)

    number_triggering_winner * Board.unmarked_number_sum(winning_board)
  end

  def score_last_winning(input) do
    {drawn_numbers, boards} = parse(input)

    {number_triggering_winner, winning_board} =
      Enum.reduce_while(drawn_numbers, boards, fn number, acc ->
        marked = Enum.map(acc, fn board -> Board.mark(board, number) end)

        if Enum.count(marked) == 1 && Board.won?(List.first(marked)) do
          {:halt, {number, List.first(marked)}}
        else
          {:cont, Enum.reject(marked, &Board.won?/1)}
        end
      end)

    number_triggering_winner * Board.unmarked_number_sum(winning_board)
  end

  defp parse(input) do
    [line_of_numbers_drawn | rest] = String.split(input)
    drawn_numbers = line_of_numbers_drawn |> String.split(",") |> Enum.map(&String.to_integer/1)
    {drawn_numbers, initialize_boards(rest)}
  end

  defp initialize_boards(board_input) do
    board_input
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(5)
    |> Enum.chunk_every(5)
    |> Enum.map(&Board.new/1)
  end
end
