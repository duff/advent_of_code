defmodule Advent2018.Day2ATest do
  use ExUnit.Case, async: true

  alias Advent2018.Day2A

  test "two?" do
    refute Day2A.two?("abcdef")
    assert Day2A.two?("bababc")
    assert Day2A.two?("abbcde")
    refute Day2A.two?("abcccd")
    assert Day2A.two?("aabcdd")
    assert Day2A.two?("abcdee")
    refute Day2A.two?("ababab")
  end

  test "three?" do
    refute Day2A.three?("abcdef")
    assert Day2A.three?("bababc")
    refute Day2A.three?("abbcde")
    assert Day2A.three?("abcccd")
    refute Day2A.three?("aabcdd")
    refute Day2A.three?("abcdee")
    assert Day2A.three?("ababab")
  end

  test "checksum" do
    input = """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    assert Day2A.checksum(input) == 12
  end

  @tag :real_input
  test "checksum real input" do
    input = """
    uqcipadzntnheslgvjjozmkfyr
    uqcipadzwtnhexlzvxjobmkfkr
    cqcipadpwtnheslgyxjobmkfyr
    ubnipadzwtnheslgvxjobmkfyw
    uqcisadzwtnheslgvxjfbmkfor
    uqcisaezwtnheslgvxkobmkfyr
    uqcguadzwtnheslgvxjobmkfir
    uqcipadzmtnhesldvxdobmkfyr
    uqcipadzwtzheslgdxjtbmkfyr
    uquipadzwtcheslgvxjobmkfbr
    uqctpadzwtnhesjbvxjobmkfyr
    ueciparzwtnheslgvxjobmkfyx
    uqcipadzwtnhessgvxjkbmkfkr
    uqcipamzwtnheslgvxioamkfyr
    uciizadzwtnheslgvxjobmkfyr
    uqcieadzwtnhesfgvxeobmkfyr
    fqcipadzwtnreslgvkjobmkfyr
    uqcipadzrtnherlgvxjobmklyr
    uqcypadzwtnheslgvxjobmkxfr
    uqcipadzwtnhemlgvxjobmvfur
    uwciuadzwwnheslgvxjobmkfyr
    uqcipadzwtnhcscgvxjobmkuyr
    upripadzwtnheslovxjobmkfyr
    uqcipadzltnheslgvxjobmkftc
    uqcipadzwtnheslgvgjobmifsr
    uqoipadzwtnheslgvxjosmkfkr
    uqcipadzwtbhesrqvxjobmkfyr
    uqcipadzwtnheslpvxjobmhfyx
    uhcinadzwtnheslgvxjybmkfyr
    uqcipadzwtnhhslgvxjabmkbyr
    uecipadzwtnheslgvxjobqyfyr
    uqcipadfwtnheslwvxjobgkfyr
    uqcipadzvtnheshgvxzobmkfyr
    fqcipadzwtcheslgvxjobmkfyt
    uecipadzwtnheslgpxjbbmkfyr
    uqclpadzwtnheslgvnjobukfyr
    qqciprdzetnheslgvxjobmkfyr
    uqcipahpwtnheslgvxjtbmkfyr
    uqcidadzwtnhesljvxyobmkfyr
    uqciradswtnqeslgvxjobmkfyr
    uqcipadzwtrhmslgvxjobmkfyf
    urcipadzjtnheslgvxfobmkfyr
    uqcipadzwznheslgvxjobmkfcv
    uqcipadowtnheslgyxjobmkfym
    uqcigadzwtnheslgvxjoomkmyr
    uqjipafzwtnheslgvejobmkfyr
    uqcioadzwtnhhslgvxzobmkfyr
    uqcgpadkwtnheslgvxjobhkfyr
    ufciiadewtnheslgvxjobmkfyr
    uqoipadzwtnheslgvxjllmkfyr
    uqcipadzutnheslgwxxobmkfyr
    uqcipadzwtlheslgaxjobmkfwr
    uqcbpadzutnheslgvxjbbmkfyr
    uucipadzwvnhesngvxjobmkfyr
    uqcifadzwtnceslgvxjoumkfyr
    ujcipadzwteheslgvxjobmkfyj
    uqcipadzwtnheslqvxjobmkuyp
    uqcipadzwtnheslgvxjoxmkxyw
    uqcipaduwtnheslgvujmbmkfyr
    uicipadnwtnheslgvxjobmbfyr
    uqcipadzwteheslgvxjobbmfyr
    uqcipadzwgnneslgvxjobmklyr
    uqcipadzxtnhwslgvbjobmkfyr
    uqcipaxwwtnheslxvxjobmkfyr
    uocipadzwtnheslgvxjobqdfyr
    uqciaauzwtnheslgtxjobmkfyr
    uncipagzwtnkeslgvxjobmkfyr
    uqcipadzwtnhehlgvxjohdkfyr
    uqcipadzwtnheslgvxjobmspyz
    uccipadzwtnhvsltvxjobmkfyr
    uacipagzwtnheslgvxjoqmkfyr
    tqcipaduwtnheslgvxjobmmfyr
    uqcipadzwtnheslgvxqebmifyr
    uecipadthtnheslgvxjobmkfyr
    uocipadzwtnhdslgvkjobmkfyr
    uqcipadtwtnheslgvxhobmufyr
    uqkipadzwtnleslgtxjobmkfyr
    uqcipadzjunheslgvxjobmnfyr
    ubcipadzwtvheslgvxjobmkfyf
    uqcipadzwpfheslgvxjsbmkfyr
    uocipadzwtndeslgvxjobmmfyr
    uqcipadzwtnheslgtxjobhkfyq
    uqcipadzwtrheslgvxjobmyfya
    uqcipadzwtvheslgvxjolgkfyr
    uqcipidzwtaheslgvxjobmkfxr
    uyzixadzwtnheslgvxjobmkfyr
    uqyihadzwtnhedlgvxjobmkfyr
    uqcipadzwtnhesltvejobqkfyr
    uqciptdzwtnheslgyxlobmkfyr
    uqcipzdzwtnhzslgvxjosmkfyr
    uqcipadzwtnbeslgexjobmkfvr
    uqcipadzwtnheslcwxjobmkkyr
    uqcapadzwcnheslgvxjolmkfyr
    uqcjpadzwtnhejlgvxjxbmkfyr
    uqcipadwwtxweslgvxjobmkfyr
    uqmipadzwtnhezlgvxjobmkyyr
    uqcipubzwtnpeslgvxjobmkfyr
    uecvpadzwtnheslgvxjocmkfyr
    uqcipadzwfnheslgvxjibmkdyr
    uqcipadzwtnheslgvxvfbykfyr
    uqcipadzwtnheslgvgjoimkfyt
    dqcqpaqzwtnheslgvxjobmkfyr
    uqcipbdzwtnheslgvxjobmkghr
    jqcipadzwtnheslgvxjgbmkzyr
    uqcipadzwtnheslgvxqkqmkfyr
    uqcipadzptnheslgvxjxbokfyr
    uucijadzwtwheslgvxjobmkfyr
    uccfpadzwtnheslgvxjobpkfyr
    uqcipadzwtnheslgvxjobakeyq
    uqcipadzwtnheolgvxqobjkfyr
    imiipadzwtnheslgvxjobmkfyr
    uqcehadzwtnheslgvxjobmkuyr
    uqcipadzztnheslgvxjorokfyr
    rqcixadzwtnheelgvxjobmkfyr
    uqcipadzwtzheslgvxjodmkfyi
    uqcipaezwtnwuslgvxjobmkfyr
    uqcipadzwtnheslggxjobjkfyq
    uqcipadzwkghesagvxjobmkfyr
    uqcypqdzwtnheslgvxjobakfyr
    iqcipadzwtnhezltvxjobmkfyr
    uxcimadzwtnheslgvxjobmxfyr
    uqcipaizwtvhwslgvxjobmkfyr
    uqcipafzwtnheslgvxjpbmkfym
    uqcipadzwinheslgvxlobmpfyr
    uqcupadzwtnheslkvxmobmkfyr
    uqcapadzwtnhesrgvxjobmkfsr
    urcipafzwtnheslgvxjobmkfur
    uqcipaczwtnheslgvbjobmknyr
    uqcizadzztgheslgvxjobmkfyr
    uqcipfdzwtnhesxgvxjobmkfyw
    uqcipbdzwtnhyslgvxjobmcfyr
    uqcipadzwanhezlgvxjobmkfwr
    uvcipadzwtnheslgvxjbkmkfyr
    uqcipajzwtnseslgvxjobmkfyq
    uqcipvdzwtnheslgvmlobmkfyr
    uqcipadzdgnheslgmxjobmkfyr
    uqcipddzwtnhestgvpjobmkfyr
    umcipadzwtdheslgvxjzbmkfyr
    uqciuwdzwtnheslgvxjobmkflr
    uqcipadzwtnheslgsxabbmkfyr
    uceipadzwtnheslgvxjobgkfyr
    mqcipadzwtnhesrgvxjobmjfyr
    aqcipadvwtnheslgvxjobmkryr
    uqsipadzwtnofslgvxjobmkfyr
    uqcixadzwtfheslgvxjzbmkfyr
    uqcipadnwfnheslgvxjohmkfyr
    uqcivadzwtnheslfvxjobmkfyz
    uqciprdzwtnheslgvxjobmkjir
    uqcipadhbtnheslgvxjoxmkfyr
    fqcipadzwtnhesfgvxjobmkfye
    uqoipqdzwtnheqlgvxjobmkfyr
    uqcipadzwtnhesltvxmobmkzyr
    uqcipadzwtnhebqgvsjobmkfyr
    uqcipadzwtnheslglxjobmfbyr
    gqcipadzwtgheslgvxjobwkfyr
    uqcipadzwtnheslgfxjzbmlfyr
    ujcnpadzwtnheslrvxjobmkfyr
    ujcivadzwtnheglgvxjobmkfyr
    uqcitadzwgnheslgvxjofmkfyr
    uqcipahzatnhmslgvxjobmkfyr
    uqzipaizwtnheslgvujobmkfyr
    uqcipadzltnheylgvnjobmkfyr
    uqcidadzwtnhwsljvxyobmkfyr
    uqcipadzwtihetlgvxjobhkfyr
    oqcipabzwtnheslgvfjobmkfyr
    uqcipadzwtnveslgvxjobzkfzr
    uqcipadzwtjheslgqxjobmlfyr
    uqcnpadzztnheslgvxjobmkoyr
    uqciuadzwonheslgvxjobmkfyz
    tqcipadzwtnheslgvxaobmqfyr
    uqcipadtwtnhqslgvxjobmkeyr
    uqcipadzwbnheslgvajobmsfyr
    ubcopadzwtnhgslgvxjobmkfyr
    uqcipydzwtwheslgvxjobakfyr
    cqbijadzwtnheslgvxjobmkfyr
    uscipadowtnheslgvxjobmkfcr
    uqcipadzwtgheslnvxjobskfyr
    uqcipzdzwtnzeslgkxjobmkfyr
    uqcipawzwtnhrslgbxjobmkfyr
    uqcipadzatchyslgvxjobmkfyr
    uqcipadzotnpeslgvxjobmjfyr
    uqcipagzwtnheslgvxjobmvfyt
    uqcipadzwhnheslgvxyobmkfyo
    uqcipadzwtnheslgmqjobmkfyc
    uqcupadzwgnheslgvcjobmkfyr
    uqcipabzwbnheslgvxjobmkwyr
    uqciiadzwtnheslgvxjobmkfmz
    uqkipauzwtnheslgvxjjbmkfyr
    uqcipidzetnheslgvxjobmkfyi
    uqcipadzwtnheslgqxjokmkfmr
    uqcipadzqtnhesllvxjobmkfyk
    uqccpadzwtnheslgmxsobmkfyr
    uqcipadzwteheslgvljfbmkfyr
    uqcipadxwinheslgaxjobmkfyr
    uqcipadzwtnheslhvxyobmkfjr
    aqcipadzwnnheslgvxjqbmkfyr
    uvcipadzwtnheszgvxjobmkfyg
    uqcipahzmtnheslgvxjobmkfir
    ukcipadzbtnheslgvxjobmkfyb
    uqcipadzwtnhemlgvqjobmkfpr
    uqcipadzwtnheslgvmeobmkfpr
    uqciphdrwtnheslgvxjobmkfyw
    uqcipadzwtnheslevxqobzkfyr
    uqcipadzwknzeslgvxnobmkfyr
    wqcipadzwjnheslgvxjobbkfyr
    uqcipadzwtdheslgvmjobmkjyr
    uqvipadzwtnhextgvxjobmkfyr
    uqhipadzwtnheslwvxjzbmkfyr
    uqcipadzwtnherlgsxjobmksyr
    uqcipadzwtnhesqgvxjotmvfyr
    udcipadzwtnhekwgvxjobmkfyr
    uqcjprdzwtnheslgvxjobmkfpr
    uqcipadzatnheclgvqjobmkfyr
    uqcbpadzctnheslqvxjobmkfyr
    uqcipadzqtnhesluvxjobrkfyr
    uqcipadzwtnhcslgvxjoomwfyr
    uqcppadzwxnheslgwxjobmkfyr
    uqcipadcwtnheslrvxjdbmkfyr
    ukcipadzwtnhhslgvxjobmkgyr
    uqckpadzwtnheslgvxjokmkiyr
    uqcspadzwtjheslgvxjobmkfjr
    uqcipadpwtnhsslgvxjobmkfyu
    uqcepadzwtnheilgvbjobmkfyr
    jqcipadiwtnheslgvxjobmkjyr
    uqcipadzrtnseslgqxjobmkfyr
    sqmipadzwtnhewlgvxjobmkfyr
    uqcieadzhtnheslgvgjobmkfyr
    uqcipadzwkwhewlgvxjobmkfyr
    uqcipadzwtzheslgvxjpbqkfyr
    uzcipadzjtnheslgvxjobmlfyr
    uqcipadzwtnheslnvxjobmkfee
    uqciyanzwtnheslgvxjoimkfyr
    uqcipadqwtnheswghxjobmkfyr
    uycipadzwtnheslovxjobmofyr
    uqcipadzwtnheslgvxcozmxfyr
    uqmipadzwtnxezlgvxjobmkfyr
    uqcipadzftnheslgvxjotmkffr
    aqcipaizwtnhesagvxjobmkfyr
    uqcipcdzwtnheslgoajobmkfyr
    uqcypadgwtnhesbgvxjobmkfyr
    uqcipcdzwtnheslgvxjebmkfyb
    uhcvpadzwtnheslgvxjobzkfyr
    uqcipadzwtnpesagvxmobmkfyr
    uqcipadzwtnidslgvxjobmkfor
    uqcipadkwtnhesigvxjzbmkfyr
    uqcypadlwtnheslsvxjobmkfyr
    qqcipadzwtnheswgvxjobmkoyr
    uqcipadzwtnheslgvxjhbmmcyr
    uqcipadzwtnhesogvxjormkfmr
    uqcipadzwtnhetcgvxgobmkfyr
    """

    assert Day2A.checksum(input) == 9139
  end
end
