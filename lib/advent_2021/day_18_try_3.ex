defmodule Advent2021.Day18.Try3 do
  def parse(input) do
    input
    |> Code.string_to_quoted!()
  end

  def add(one, two) do
    [one ++ two]
  end

  def magnitude([left, right]) do
    magnitude(left) * 3 + magnitude(right) * 2
  end

  def magnitude(value) do
    value
  end

  def split([left, right]) do
    case split(left) do
      {false, left} ->
        case split(right) do
          {false, right} ->
            {false, [left, right]}

          {true, right} ->
            {true, [left, right]}
        end

      {true, left} ->
        {true, [left, right]}
    end
  end

  def split(val) when is_integer(val) and val > 9 do
    {true, [div(val, 2), ceil(val / 2)]}
  end

  def split(val), do: {false, val}
end
