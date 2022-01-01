defmodule Advent2021.Day08 do
  def one_four_seven_eight_count(input) do
    input
    |> input_to_list
    |> Enum.map(fn map -> Enum.count(map.output, fn output -> String.length(output) in [2, 3, 4, 7] end) end)
    |> Enum.sum
  end

  defp input_to_list(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn e -> String.split(e, [" ", " | "]) end)
    |> Enum.map(fn list ->
      {signals, output} = Enum.split(list, 10)
      %{signals: signals, output: output}
    end)
  end
end
