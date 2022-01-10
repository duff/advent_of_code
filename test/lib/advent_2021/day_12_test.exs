defmodule Advent2021.Day12Test do
  use ExUnit.Case, async: true

  alias Advent2021.Day12

  test "path_count" do
    assert Day12.path_count(input()) == 10
    assert Day12.path_count(another_input()) == 19
    assert Day12.path_count(third_input()) == 226
    assert Day12.path_count(real_input()) == 4707
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
