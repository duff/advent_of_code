defmodule Advent2021.Day18 do
  def parse(input) do
    input
    |> Code.string_to_quoted!()
    |> new()
  end

  def new([left, right]) when is_integer(left) and is_integer(right) do
    {[left, right], 0}
  end

  def new([left, right]) when is_integer(right) do
    left = new(left)
    {[left, right], elem(left, 1)}
  end

  def new([left, right]) when is_integer(left) do
    right = new(right)
    {[left, right], elem(right, 1)}
  end

  def new([left, right]) do
    left = new(left)
    right = new(right)
    {[left, right], Enum.max([elem(right, 1), elem(left, 1)]) + 1}
  end

  def add(one, two) do
    {[one, two], Enum.max([elem(one, 1), elem(two, 1)]) + 1}
  end

  def magnitude({[left, right], _}) when is_integer(left) and is_integer(right) do
    left * 3 + right * 2
  end

  def magnitude({[left, right], _}) when is_integer(right) do
    (magnitude(left) * 3) + right * 2
  end

  def magnitude({[left, right], _}) when is_integer(right) do
    left * 3 + (magnitude(right) * 2)
  end

  def magnitude({[left, right], _}) do
    (magnitude(left) * 3) + (magnitude(right) * 2)
  end

  # def split(snum) do
  #   index_needing_split = Enum.find_index(snum, fn {num, _depth} -> num > 9 end)

  #   if index_needing_split do
  #     {true, split_at(snum, index_needing_split)}
  #   else
  #     {false, snum}
  #   end
  # end

  # defp split_at(snum, index) do
  #   snum
  #   |> List.update_at(index, fn {num, depth} ->
  #     result = num / 2
  #     [{floor(result), depth + 1}, {ceil(result), depth + 1}]
  #   end)
  #   |> List.flatten()
  # end
end
