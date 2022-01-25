defmodule SNum do
  defstruct ~w(left right)a

  def parse(input) do
    input
    |> Code.string_to_quoted!()
    |> new()
  end

  def add(one, two) do
    %SNum{left: one, right: two}
  end

  def new(ast), do: new(ast, %SNum{})

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

  def magnitude(%SNum{left: left, right: right}) do
    magnitude(left) * 3 + magnitude(right) * 2
  end

  def magnitude(int) when is_integer(int), do: int

  def split(%SNum{left: left, right: right}) do
    case split(left) do
      {false, left} ->
        case split(right) do
          {false, right} ->
            {false, %SNum{left: left, right: right}}

          {true, right} ->
            {true, %SNum{left: left, right: right}}
        end

      {true, left} ->
        {true, %SNum{left: left, right: right}}
    end
  end

  def split(val) when is_integer(val) and val > 9 do
    result = val / 2
    {true, %SNum{left: floor(result), right: ceil(result)}}
  end

  def split(val), do: {false, val}
end
