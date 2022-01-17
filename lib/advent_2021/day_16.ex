defprotocol Advent2021.Day16.Packet.VersionTotal do
  def versions(packet)
end

defmodule Advent2021.Day16.Packet.LiteralValue do
  alias Advent2021.Day16.Packet.{LiteralValue, VersionTotal}

  defstruct ~w(version amount bitcount)a

  def new(version, value_bits) do
    %LiteralValue{version: version, amount: Integer.undigits(value_bits, 2), bitcount: length(value_bits) + 6}
  end

  defimpl VersionTotal do
    def versions(%LiteralValue{version: version}), do: [version]
  end
end

defmodule Advent2021.Day16.Packet.Operator do
  alias Advent2021.Day16.Packet.{Operator, VersionTotal}

  defstruct ~w(version subpackets)a

  def new(version, subpackets) do
    %Operator{version: version, subpackets: subpackets}
  end

  defimpl VersionTotal do
    def versions(%Operator{version: version, subpackets: subpackets}) do
      subpackets
      |> Enum.map(&VersionTotal.versions/1)
      |> Enum.concat([version])
      |> List.flatten
    end
  end
end

defmodule Advent2021.Day16 do
  alias Advent2021.Day16.Packet.{LiteralValue, Operator, VersionTotal}

  def sum_version_numbers(input) do
    input
    |> binary_digits
    |> packets
    |> Enum.flat_map(&VersionTotal.versions/1)
    |> Enum.sum
  end

  defp binary_digits(input) do
    input
    |> String.graphemes()
    |> Enum.flat_map(&grapheme_to_binary_digits/1)
  end

  defp packets(bits) do
    packets(bits, [])
  end

  defp packets([a, b, c, 1, 0, 0 | rest], results) do
    {value_bits, after_literal} = literal_value_bits(rest)
    packets(after_literal, [LiteralValue.new(version([a, b, c]), value_bits) | results])
  end

  defp packets([a, b, c, _, _, _ | rest], results) do
    {subpackets, after_packet} = operator_subpackets(rest)
    packets(after_packet, [Operator.new(version([a, b, c]), subpackets) | results])
  end

  defp packets(_weird_bits_left, results) do
    results
  end

  # Not yet handling the organization of the operator with X # of subpackets
  # For now, everything is a subpacket which works since for part 1 we
  # only care about adding all of the version numbers together. I suspect
  # this will change for part 2.
  defp operator_subpackets([1 | rest]) do
    {_number_of_subpackets_bits, remainder} = Enum.split(rest, 11)
    # number_of_subpackets = Integer.undigits(number_of_subpackets_bits, 2)

    rest_of_packets = packets(remainder)
    # {actual_subpackets, re_parsable_packets} = Enum.split(rest_of_packets, number_of_subpackets)

    {rest_of_packets, []}
  end

  defp operator_subpackets([0 | rest]) do
    {subpacket_length_bits, remainder} = Enum.split(rest, 15)
    subpacket_length = Integer.undigits(subpacket_length_bits, 2)

    {subpacket_bits, another_remainder} = Enum.split(remainder, subpacket_length)
    subpackets = packets(subpacket_bits, [])
    {subpackets, another_remainder}
  end

  defp operator_subpackets([]) do
    {[], []}
  end

  defp literal_value_bits([0, two, three, four, five | rest], literal_value_result) do
    bits =
      [[two, three, four, five] | literal_value_result]
      |> Enum.reverse()
      |> List.flatten()

    # |> Integer.undigits(2)

    {bits, rest}
  end

  defp literal_value_bits([1, two, three, four, five | rest], literal_value_result) do
    literal_value_bits(rest, [[two, three, four, five] | literal_value_result])
  end

  defp literal_value_bits(bits) do
    literal_value_bits(bits, [])
  end

  defp grapheme_to_binary_digits(grapheme) do
    grapheme
    |> String.to_integer(16)
    |> Integer.to_string(2)
    |> String.pad_leading(4, "0")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp version(bits) do
    Integer.undigits(bits, 2)
  end
end
