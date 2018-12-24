defmodule Advent2018.Day16.Sample do
  defstruct pre_registers: [], post_registers: [], opcode: nil, instruction_params: []
end

defmodule Advent2018.Day16 do
  use Bitwise

  alias Advent2018.Day16.Sample

  @opcodes ~w[addi addr mulr muli banr bani borr bori setr seti gtir gtri gtrr eqir eqri eqrr]a

  def part_a(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&opcode_count_for_sample/1)
    |> Enum.count(&(&1 >= 3))
  end

  def opcode_count_for_sample(input) do
    sample = parse(input)

    Enum.count(@opcodes, fn opcode ->
      execute(opcode, sample.instruction_params, sample.pre_registers) == sample.post_registers
    end)
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
    if a > Enum.at(registers, b) do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  def execute(:setr, [a, _b, c], registers) do
    set_value(registers, c, Enum.at(registers, a))
  end

  def execute(:seti, [a, _b, c], registers) do
    set_value(registers, c, a)
  end

  def execute(:gtri, [a, b, c], registers) do
    if Enum.at(registers, a) > b do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  def execute(:gtrr, [a, b, c], registers) do
    if Enum.at(registers, a) > Enum.at(registers, b) do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  def execute(:eqir, [a, b, c], registers) do
    if a == Enum.at(registers, b) do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  def execute(:eqri, [a, b, c], registers) do
    if Enum.at(registers, a) == b do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  def execute(:eqrr, [a, b, c], registers) do
    if Enum.at(registers, a) == Enum.at(registers, b) do
      set_value(registers, c, 1)
    else
      set_value(registers, c, 0)
    end
  end

  defp set_value(registers, index, value) do
    List.replace_at(registers, index, value)
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
end
