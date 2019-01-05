defmodule Advent2018.Day19.Program do
  defstruct ip_register: nil, instructions: nil, registers: [0, 0, 0, 0, 0, 0]
end

defmodule Advent2018.Day19 do
  use Bitwise

  alias Advent2018.Day19.Program

  def part_a(input) do
    input
    |> parse
    |> run
    |> register_0
  end

  def part_b(input) do
    %{parse(input) | registers: [1, 0, 0, 0, 0, 0]}
    |> run
    |> register_0
  end

  defp run(program) do
    program
    |> run(next_instruction(program))
  end

  defp run(program, nil), do: program

  defp run(program, instruction) do
    program
    |> execute(instruction)
    |> run
  end

  defp next_instruction(program) do
    Enum.at(program.instructions, ip_value(program))
  end

  defp execute(%Program{registers: regs} = program, [:addi, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) + b)
  end

  defp execute(%Program{registers: regs} = program, [:addr, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) + Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:mulr, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) * Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:muli, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) * b)
  end

  defp execute(%Program{registers: regs} = program, [:banr, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) &&& Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:bani, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) &&& b)
  end

  defp execute(%Program{registers: regs} = program, [:borr, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) ||| Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:bori, a, b, c]) do
    set_value(program, c, Enum.at(regs, a) ||| b)
  end

  defp execute(%Program{registers: regs} = program, [:setr, a, _b, c]) do
    set_value(program, c, Enum.at(regs, a))
  end

  defp execute(program, [:seti, a, _b, c]) do
    set_value(program, c, a)
  end

  defp execute(%Program{registers: regs} = program, [:gtir, a, b, c]) do
    set_boolean_value(program, c, a > Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:gtri, a, b, c]) do
    set_boolean_value(program, c, Enum.at(regs, a) > b)
  end

  defp execute(%Program{registers: regs} = program, [:gtrr, a, b, c]) do
    set_boolean_value(program, c, Enum.at(regs, a) > Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:eqir, a, b, c]) do
    set_boolean_value(program, c, a == Enum.at(regs, b))
  end

  defp execute(%Program{registers: regs} = program, [:eqri, a, b, c]) do
    set_boolean_value(program, c, Enum.at(regs, a) == b)
  end

  defp execute(%Program{registers: regs} = program, [:eqrr, a, b, c]) do
    set_boolean_value(program, c, Enum.at(regs, a) == Enum.at(regs, b))
  end

  defp set_value(%Program{registers: regs} = program, index, value) do
    %{program | registers: List.replace_at(regs, index, value)}
    |> increment_ip
  end

  defp increment_ip(%Program{registers: regs, ip_register: ip_register} = program) do
    %{program | registers: List.replace_at(regs, ip_register, ip_value(program) + 1)}
  end

  defp ip_value(%Program{registers: regs, ip_register: ip_register}) do
    Enum.at(regs, ip_register)
  end

  defp set_boolean_value(program, index, condition) do
    if condition do
      set_value(program, index, 1)
    else
      set_value(program, index, 0)
    end
  end

  defp parse(input) do
    ["#ip " <> ip_register | instruction_lines] = String.split(input, "\n", trim: true)
    instructions = Enum.map(instruction_lines, &parse_line/1)

    %Program{ip_register: String.to_integer(ip_register), instructions: instructions}
  end

  defp parse_line(line) do
    [opcode, a, b, c] = String.split(line)
    [String.to_atom(opcode), String.to_integer(a), String.to_integer(b), String.to_integer(c)]
  end

  defp register_0(%Program{registers: regs}), do: List.first(regs)
end
