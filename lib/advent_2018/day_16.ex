defmodule Advent2018.Day16.Sample do
  defstruct pre_registers: [], post_registers: [], opcode: nil, instruction_params: []
end

defmodule Advent2018.Day16 do
  import Bitwise

  alias Advent2018.Day16.Sample

  @opcodes ~w[addi addr mulr muli banr bani borr bori setr seti gtir gtri gtrr eqir eqri eqrr]a

  def part_a(input) do
    input
    |> samples
    |> Enum.map(&opcode_count_for_sample/1)
    |> Enum.count(&(&1 >= 3))
  end

  def part_b(input_samples, input_program) do
    opcodes = opcode_map(input_samples)

    input_program
    |> instructions
    |> Enum.reduce(starting_registers(), fn [opcode_num, a, b, c], acc ->
      execute(opcodes[opcode_num], [a, b, c], acc)
    end)
    |> List.first()
  end

  defp opcode_map(input_samples) do
    input_samples
    |> samples
    |> Enum.map(&opcodes_for_sample/1)
    |> Enum.group_by(fn {opcode, _} -> opcode end, fn {_, opcode_names} -> opcode_names end)
    |> Enum.map(fn {opcode, opcode_names} -> {opcode, List.flatten(opcode_names) |> Enum.uniq()} end)
    |> deduce
    |> List.flatten()
    |> Enum.map(fn {opcode, [opcode_name]} -> {opcode, opcode_name} end)
    |> Map.new()
  end

  defp deduce(entries), do: deduce(entries, [])

  defp deduce([], acc), do: acc

  defp deduce(entries, acc) do
    {solos, rest} =
      Enum.split_with(entries, fn {_, opcode_names} ->
        length(opcode_names) == 1
      end)

    deduce(remove_solos(rest, solos), [solos | acc])
  end

  defp remove_solos(entries, solos) do
    which_ones = Enum.map(solos, fn {_, [x]} -> x end)

    Enum.map(entries, fn {opcode, opcode_names} ->
      {opcode, Enum.reject(opcode_names, fn e -> e in which_ones end)}
    end)
  end

  def opcode_count_for_sample(input) do
    sample = parse(input)

    Enum.count(@opcodes, fn opcode ->
      execute(opcode, sample.instruction_params, sample.pre_registers) == sample.post_registers
    end)
  end

  def opcodes_for_sample(input) do
    sample = parse(input)

    opcode_names =
      Enum.filter(@opcodes, fn opcode ->
        execute(opcode, sample.instruction_params, sample.pre_registers) == sample.post_registers
      end)

    {sample.opcode, opcode_names}
  end

  def execute(:addi, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) + b)
  end

  def execute(:addr, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) + Enum.at(registers, b))
  end

  def execute(:mulr, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) * Enum.at(registers, b))
  end

  def execute(:muli, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) * b)
  end

  def execute(:banr, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) &&& Enum.at(registers, b))
  end

  def execute(:bani, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) &&& b)
  end

  def execute(:borr, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) ||| Enum.at(registers, b))
  end

  def execute(:bori, [a, b, c], registers) do
    set_value(registers, c, Enum.at(registers, a) ||| b)
  end

  def execute(:gtir, [a, b, c], registers) do
    set_boolean_value(registers, c, a > Enum.at(registers, b))
  end

  def execute(:setr, [a, _b, c], registers) do
    set_value(registers, c, Enum.at(registers, a))
  end

  def execute(:seti, [a, _b, c], registers) do
    set_value(registers, c, a)
  end

  def execute(:gtri, [a, b, c], registers) do
    set_boolean_value(registers, c, Enum.at(registers, a) > b)
  end

  def execute(:gtrr, [a, b, c], registers) do
    set_boolean_value(registers, c, Enum.at(registers, a) > Enum.at(registers, b))
  end

  def execute(:eqir, [a, b, c], registers) do
    set_boolean_value(registers, c, a == Enum.at(registers, b))
  end

  def execute(:eqri, [a, b, c], registers) do
    set_boolean_value(registers, c, Enum.at(registers, a) == b)
  end

  def execute(:eqrr, [a, b, c], registers) do
    set_boolean_value(registers, c, Enum.at(registers, a) == Enum.at(registers, b))
  end

  defp set_value(registers, index, value) do
    List.replace_at(registers, index, value)
  end

  defp set_boolean_value(registers, index, condition) do
    if condition do
      set_value(registers, index, 1)
    else
      set_value(registers, index, 0)
    end
  end

  defp parse([pre_register_line, instruction_line, post_register_line]) do
    <<"Before: [", pre_register_strings::binary-size(10), _rest::binary>> = pre_register_line
    <<"After:  [", post_register_strings::binary-size(10), _rest::binary>> = post_register_line
    instruction_ints = String.split(instruction_line, " ") |> Enum.map(&String.to_integer/1)
    [opcode | instruction_params] = instruction_ints

    %Sample{
      pre_registers: register_ints(pre_register_strings),
      post_registers: register_ints(post_register_strings),
      instruction_params: instruction_params,
      opcode: opcode
    }
  end

  defp register_ints(strings) do
    String.split(strings, ", ") |> Enum.map(&String.to_integer/1)
  end

  defp starting_registers(), do: [0, 0, 0, 0]

  defp samples(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
  end

  defp instructions(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
