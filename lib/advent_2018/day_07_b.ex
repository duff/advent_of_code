defmodule Advent2018.Day07B do
  alias Advent2018.Day07B

  defstruct instructions: nil,
            possible_steps: nil,
            requirements: nil,
            ready_steps: [],
            recipe: [],
            all_steps: nil,
            available_workers: 0,
            total_seconds: 0,
            in_progress_steps: [],
            time_delta: nil

  def new_state do
    %Day07B{}
  end

  def duration(input, number_of_workers, time_delta) do
    input
    |> initialize_state(number_of_workers, time_delta)
    |> process
  end

  defp initialize_state(input, number_of_workers, time_delta) do
    new_state()
    |> instructions(input)
    |> possible_steps
    |> requirements
    |> all_steps
    |> ready_those_without_requirements
    |> init_worker_counts(number_of_workers)
    |> update_time_delta(time_delta)
  end

  defp process(state = %Day07B{ready_steps: [_ | _]}) do
    state
    |> queue_steps
    |> work_on_in_progress_steps
    |> process
  end

  defp process(state = %Day07B{ready_steps: [], in_progress_steps: []}) do
    state.total_seconds
  end

  defp process(state = %Day07B{ready_steps: []}) do
    state
    |> work_on_in_progress_steps
    |> process
  end

  defp work_on_in_progress_steps(state) do
    state
    |> add_a_second
    |> decrement_each_in_progress
    |> handle_completed_steps
  end

  defp handle_completed_steps(state) do
    completed = for {step, 0} <- state.in_progress_steps, do: step

    state
    |> update_in_progress_steps_and_recipe(completed)
    |> move_available_worker_count_by(Enum.count(completed))
    |> add_more_ready_steps(completed)
  end

  defp update_in_progress_steps_and_recipe(state, completed) do
    new_in_progress_steps = Enum.reject(state.in_progress_steps, fn {_step, remaining_time} -> remaining_time == 0 end)
    new_items_added_to_recipe = completed ++ state.recipe

    %{state | in_progress_steps: new_in_progress_steps, recipe: new_items_added_to_recipe}
  end

  defp decrement_each_in_progress(state) do
    result =
      state.in_progress_steps
      |> Enum.map(fn {step, remaining_time} ->
        {step, remaining_time - 1}
      end)

    %{state | in_progress_steps: result}
  end

  defp queue_steps(state) do
    taken = Enum.take(state.ready_steps, state.available_workers)
    num_taken = Enum.count(taken)
    new_in_progress_steps = taken |> Enum.map(fn each -> {each, required_time(each, state)} end)

    state
    |> move_available_worker_count_by(-num_taken)
    |> Map.update(:in_progress_steps, new_in_progress_steps, &(&1 ++ new_in_progress_steps))
    |> remove_from_ready(taken)
  end

  defp remove_from_ready(state, taken) do
    Map.update!(state, :ready_steps, fn value -> Enum.reject(value, &(&1 in taken)) end)
  end

  defp move_available_worker_count_by(state, num) do
    Map.update!(state, :available_workers, &(&1 + num))
  end

  defp required_time([letter], state), do: letter - state.time_delta

  defp init_worker_counts(state, number_of_workers) do
    %{state | available_workers: number_of_workers}
  end

  defp update_time_delta(state, time_delta) do
    %{state | time_delta: time_delta}
  end

  defp add_a_second(state) do
    Map.update!(state, :total_seconds, &(&1 + 1))
  end

  defp add_more_ready_steps(state, []), do: state

  defp add_more_ready_steps(state, completed) do
    result =
      Enum.reduce(completed, [], fn each_completed, acc ->
        next_potential_steps = state.possible_steps[each_completed] || []

        Enum.reduce(next_potential_steps, acc, fn each, acc ->
          if MapSet.subset?(MapSet.new(state.requirements[each]), MapSet.new(state.recipe)) do
            [each | acc]
          else
            acc
          end
        end)
      end)

    make_ready(state, result)
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

  defp instructions(state, input) do
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
