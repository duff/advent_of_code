defmodule Advent2021.Day12BTest do
  use ExUnit.Case, async: true

  alias Advent2021.Day12B.Visited
  alias Advent2021.Day12B

  test "visited" do
    v = Visited.new()
    assert Visited.remember(v, "UPPER") == v

    v = Visited.remember(v, "uno")
    assert Visited.done?(v, "uno") == false

    v = Visited.remember(v, "dos")
    assert Visited.done?(v, "dos") == false
    assert Visited.done?(v, "uno") == false

    v = Visited.remember(v, "uno")
    assert Visited.done?(v, "uno") == true
    assert Visited.done?(v, "dos") == true
    assert Visited.done?(v, "tres") == false

    v = Visited.remember(v, "tres")
    assert Visited.done?(v, "tres") == true
  end

  test "path_count" do
    assert Day12B.path_count(input()) == 36
    assert Day12B.path_count(another_input()) == 103
    assert Day12B.path_count(third_input()) == 3509
  end

  @tag :real_data_slow
  test "path_count real" do
    assert Day12B.path_count(real_input()) == 130_493
  end

  defp input do
    """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """
  end

  defp another_input do
    """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """
  end

  defp third_input do
    """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """
  end

  defp real_input do
    """
    start-YY
    av-rz
    rz-VH
    fh-av
    end-fh
    sk-gp
    ae-av
    YY-gp
    end-VH
    CF-qz
    qz-end
    qz-VG
    start-gp
    VG-sk
    rz-YY
    VH-sk
    rz-gp
    VH-av
    VH-fh
    sk-rz
    YY-sk
    av-gp
    rz-qz
    VG-start
    sk-fh
    VG-av
    """
  end
end
