defprotocol Advent2021.Day16B.Packet do
  def versions(packet)
  def value(packet)
end

defmodule Advent2021.Day16B.Packet.LiteralValue do
  alias Advent2021.Day16B.Packet
  alias Advent2021.Day16B.Packet.LiteralValue

  defstruct ~w(version amount)a

  def new(version, value_bits) do
    %LiteralValue{version: version, amount: Integer.undigits(value_bits, 2)}
  end

  defimpl Packet do
    def versions(%LiteralValue{version: version}), do: [version]
    def value(%LiteralValue{amount: amount}), do: amount
  end
end

defmodule Advent2021.Day16B.Packet.Operator do
  alias Advent2021.Day16B.Packet
  alias Advent2021.Day16B.Packet.Operator

  defstruct ~w(version subpackets type_id_bits)a

  def new(version, type_id_bits, subpackets) do
    %Operator{version: version, type_id_bits: type_id_bits, subpackets: subpackets}
  end

  defimpl Packet do
    def versions(%Operator{version: version, subpackets: subpackets}) do
      subpackets
      |> Enum.map(&Packet.versions/1)
      |> Enum.concat([version])
      |> List.flatten()
    end

    def value(%Operator{type_id_bits: type_id_bits, subpackets: subpackets}) do
      subpackets
      |> Enum.map(&Packet.value/1)
      |> perform(type_id_bits)
    end

    defp perform(values, [0, 0, 0]), do: Enum.sum(values)
    defp perform(values, [0, 0, 1]), do: Enum.product(values)
    defp perform(values, [0, 1, 0]), do: Enum.min(values)
    defp perform(values, [0, 1, 1]), do: Enum.max(values)
    defp perform([first, second], [1, 1, 0]) when first > second, do: 1
    defp perform([first, second], [1, 0, 1]) when first < second, do: 1
    defp perform([same, same], [1, 1, 1]), do: 1
    defp perform([_, _], _type_id_bits), do: 0
  end
end

defmodule Advent2021.Day16B do
  alias Advent2021.Day16B.Packet
  alias Advent2021.Day16B.Packet.{LiteralValue, Operator}

  def sum_version_numbers(input) do
    input
    |> binary_digits
    |> packets
    |> Enum.flat_map(&Packet.versions/1)
    |> Enum.sum()
  end

  def value(input) do
    input
    |> binary_digits
    |> packets
    |> first_packet_value
  end

  defp first_packet_value([first_packet | _]) do
    Packet.value(first_packet)
  end

  defp binary_digits(input) do
    input
    |> String.graphemes()
    |> Enum.flat_map(&grapheme_to_binary_digits/1)
  end

  defp packets(bits) do
    packets(bits, [])
  end

  defp packets(bits, results) do
    case retrieve_next_packet(bits) do
      {packet, rest} -> packets(rest, [packet | results])
      :no_mas -> results
    end
  end

  defp retrieve_next_packet([a, b, c, 1, 0, 0 | rest]) do
    {value_bits, after_literal} = literal_value_bits(rest)
    {LiteralValue.new(version([a, b, c]), value_bits), after_literal}
  end

  defp retrieve_next_packet([a, b, c, d, e, f | rest]) do
    {subpackets, after_packet} = operator_subpackets(rest)
    {Operator.new(version([a, b, c]), [d, e, f], subpackets), after_packet}
  end

  defp retrieve_next_packet(_weird_bits_left) do
    :no_mas
  end

  defp operator_subpackets([1 | rest]) do
    {number_of_subpackets_bits, remainder} = Enum.split(rest, 11)
    number_of_subpackets = Integer.undigits(number_of_subpackets_bits, 2)

    {actual_subpackets, actual_remaining} =
      Enum.reduce(1..number_of_subpackets, {[], remainder}, fn _, {packets, remaining} ->
        {packet, rest} = retrieve_next_packet(remaining)
        {[packet | packets], rest}
      end)

    {actual_subpackets, actual_remaining}
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
