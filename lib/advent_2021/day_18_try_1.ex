defmodule Advent2021.Day18.Try1 do
  defstruct ~w(left right)a

  alias Advent2021.Day18.Try1

  def parse(input) do
    input
    |> Code.string_to_quoted!()
    |> new()
  end

  def add(one, two) do
    %Try1{left: one, right: two}
  end

  def new(ast), do: new(ast, %Try1{})

  def new([left, right], snum) when is_integer(left) and is_integer(right) do
    %{snum | left: left, right: right}
  end

  def new([left, right], snum) when is_integer(right) do
    %{snum | left: new(left), right: right}
  end

  def new([left, right], snum) when is_integer(left) do
    %{snum | left: left, right: new(right)}
  end

  def new([left, right], snum) do
    %{snum | left: new(left), right: new(right)}
  end

  def magnitude(%Try1{left: left, right: right}) do
    magnitude(left) * 3 + magnitude(right) * 2
  end

  def magnitude(int) when is_integer(int), do: int

  def split(%Try1{left: left, right: right}) do
    case split(left) do
      {false, left} ->
        case split(right) do
          {false, right} ->
            {false, %Try1{left: left, right: right}}

          {true, right} ->
            {true, %Try1{left: left, right: right}}
        end

      {true, left} ->
        {true, %Try1{left: left, right: right}}
    end
  end

  def split(val) when is_integer(val) and val > 9 do
    result = val / 2
    {true, %Try1{left: floor(result), right: ceil(result)}}
  end

  def split(val), do: {false, val}
end
