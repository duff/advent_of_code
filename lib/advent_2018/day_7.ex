defmodule Advent2018.Day7 do
  alias Advent2018.Day7

  defstruct instructions: nil, possible_steps: nil, requirements: nil, ready_steps: [], recipe: [], all_steps: nil

  def new_state do
    %Day7{}
  end

  def order(input) do
    input
    |> instructions(new_state())
    |> possible_steps()
    |> requirements()
    |> all_steps()
    |> ready_those_without_requirements()
    |> process()
  end

  defp process(state = %Day7{ready_steps: [next_step_to_take | tail]}) do
    state
    |> Map.update!(:recipe, &[next_step_to_take | &1])
    |> Map.put(:ready_steps, tail)
    |> add_more_ready_steps(next_step_to_take)
    |> process()
  end

  defp process(state = %Day7{ready_steps: []}) do
    state.recipe
    |> Enum.reverse()
    |> to_string()
  end

  defp add_more_ready_steps(state, taken_step) do
    next_potential_steps = state.possible_steps[taken_step] || []

    result =
      Enum.filter(next_potential_steps, fn each ->
        MapSet.subset?(MapSet.new(state.requirements[each]), MapSet.new(state.recipe))
      end)

    make_ready(state, result)
  end

  defp all_requirements_met?(step, state) do
    MapSet.subset?(MapSet.new(state.requirements[step]), MapSet.new(state.recipe))
  end

  defp ready_those_without_requirements(state) do
    sans_requirements = Enum.reject(state.all_steps, fn each -> each in Map.keys(state.requirements) end)
    make_ready(state, sans_requirements)
  end

  defp make_ready(state, steps_to_add) do
    Map.update!(state, :ready_steps, fn value -> (value ++ steps_to_add) |> Enum.sort() end)
  end

  defp all_steps(state) do
    result = MapSet.new(Map.keys(state.requirements) ++ Map.keys(state.possible_steps))
    %{state | all_steps: result}
  end

  defp possible_steps(state) do
    result = Enum.group_by(state.instructions, fn [first, _] -> first end, fn [_, second] -> second end)
    %{state | possible_steps: result}
  end

  defp requirements(state) do
    result = Enum.group_by(state.instructions, fn [_, second] -> second end, fn [first, _] -> first end)
    %{state | requirements: result}
  end

  defp instructions(input, state) do
    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Regex.run(step_regex(), &1, capture: :all_but_first))
      |> Enum.map(fn [a, b] -> [String.to_charlist(a), String.to_charlist(b)] end)

    %{state | instructions: result}
  end

  defp step_regex do
    ~r/Step (.).*step (.)/
  end
end
