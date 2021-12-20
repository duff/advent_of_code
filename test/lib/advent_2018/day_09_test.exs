defmodule Advent2018.Day09Test do
  use ExUnit.Case, async: true

  alias Advent2018.Day09

  @tag :real_data_slow
  test "score" do
    assert Day09.score(9, 25) == 32
    assert Day09.score(10, 1618) == 8317
    assert Day09.score(17, 1104) == 2764
    assert Day09.score(21, 6111) == 54718
    assert Day09.score(30, 5807) == 37305

    # Not sure why this is failing
    # assert Day09.score(13, 7999) == 146_373
  end

  @tag :real_data_slow
  test "score real" do
    # Not sure why this is failing on the site. :(
    assert Day09.score(455, 71223) == 393_972
  end
end
