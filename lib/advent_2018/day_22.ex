defmodule Advent2018.Day22.Survey do
  defstruct x_target: nil,
            y_target: nil,
            x_max: nil,
            y_max: nil,
            depth: nil,
            risks: [],
            regions: %{},
            erosion_cache: %{},
            visited: MapSet.new(),
            graph: %{}
end

defmodule Advent2018.Day22 do
  alias Advent2018.Day22.Survey

  def part_a(depth, target_coordinates) do
    initialize(depth, target_coordinates)
    |> add_risks(target_coordinates)
    |> risk_total
  end

  def part_b(depth, target_coordinates) do
    initialize(depth, target_coordinates)
    |> add_regions
    |> shortest_time
  end

  defp shortest_time(survey) do
    mouth = {{0, 0}, :torch}
    new_graph = Map.put(survey.graph, mouth, {0, nil})

    %{survey | graph: new_graph}
    |> add_node(mouth)
  end

  defp add_node(%Survey{x_target: x, y_target: y} = survey, {{x, y}, :torch} = target_node) do
    distance(survey, target_node)
  end

  defp add_node(survey, from_node) do
    new_survey = %{survey | graph: updated_graph(survey, from_node), visited: MapSet.put(survey.visited, from_node)}
    add_node(new_survey, next_node(new_survey))
  end

  defp updated_graph(survey, from_node) do
    (new_tool_nodes(survey, from_node) ++ connected_nodes_using_same_tool(survey, from_node))
    |> Enum.reduce(survey.graph, fn {node, distance}, acc ->
      Map.update(acc, node, {distance, from_node}, fn {existing_distance, _previous_node} = existing ->
        if distance < existing_distance do
          {distance, from_node}
        else
          existing
        end
      end)
    end)
  end

  defp next_node(%Survey{graph: graph, visited: visited}) do
    {next_one, _} =
      Enum.min_by(graph, fn {node, {distance, _}} ->
        !MapSet.member?(visited, node) && distance
      end)

    next_one
  end

  defp new_tool_nodes(survey, {from_coord, from_tool} = from_node) do
    region = region(survey, from_coord)
    [new_tool] = possible_tools(region) -- [from_tool]

    if MapSet.member?(survey.visited, {from_coord, new_tool}) do
      []
    else
      [{{from_coord, new_tool}, 7 + distance(survey, from_node)}]
    end
  end

  defp connected_nodes_using_same_tool(survey, {from_coord, from_tool} = from_node) do
    for coord <- adjacent_coords(from_coord),
        region = region(survey, coord),
        from_tool in possible_tools(region),
        !MapSet.member?(survey.visited, {coord, from_tool}) do
      {{coord, from_tool}, 1 + distance(survey, from_node)}
    end
  end

  defp distance(%Survey{graph: graph}, from_node) do
    {distance, _} = Map.get(graph, from_node)
    distance
  end

  defp region(%Survey{regions: regions}, coord), do: Map.get(regions, coord)

  defp possible_tools(:rocky), do: [:climbing_gear, :torch]
  defp possible_tools(:wet), do: [:climbing_gear, :neither]
  defp possible_tools(:narrow), do: [:torch, :neither]

  defp adjacent_coords({x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.reject(fn {x, y} -> x < 0 || y < 0 end)
  end

  defp add_risks(survey, {x_target, y_target}) do
    Enum.reduce(0..y_target, survey, fn y, acc ->
      Enum.reduce(0..x_target, acc, fn x, acc ->
        add_risk(acc, {x, y})
      end)
    end)
  end

  defp add_regions(survey) do
    Enum.reduce(0..survey.y_max, survey, fn y, acc_x ->
      Enum.reduce(0..survey.x_max, acc_x, fn x, acc ->
        add_region(acc, {x, y})
      end)
    end)
  end

  defp add_risk(survey, coord) do
    survey
    |> cache_erosion(coord)
    |> remember_risk(coord)
  end

  defp add_region(survey, coord) do
    survey
    |> cache_erosion(coord)
    |> remember_region(coord)
  end

  defp remember_risk(survey, coord) do
    new_risk = risk(survey, coord)
    %{survey | risks: [new_risk | survey.risks]}
  end

  defp remember_region(%Survey{regions: regions} = survey, coord) do
    new_region = risk(survey, coord) |> region
    new_regions = Map.put(regions, coord, new_region)

    %{survey | regions: new_regions}
  end

  defp cache_erosion(%Survey{erosion_cache: cache} = survey, coord) do
    new_cache =
      Map.put_new_lazy(cache, coord, fn ->
        (geologic_index(survey, coord) + survey.depth)
        |> Integer.mod(20183)
      end)

    %{survey | erosion_cache: new_cache}
  end

  defp risk(survey, coord) do
    erosion_level(survey, coord)
    |> Integer.mod(3)
  end

  defp region(0), do: :rocky
  defp region(1), do: :wet
  defp region(2), do: :narrow

  defp geologic_index(_survey, {0, 0}), do: 0
  defp geologic_index(%Survey{x_target: x, y_target: y}, {x, y}), do: 0

  defp geologic_index(_survey, {x, 0}) do
    x * 16807
  end

  defp geologic_index(_survey, {0, y}) do
    y * 48271
  end

  defp geologic_index(survey, {x, y}) do
    erosion_level(survey, {x - 1, y}) * erosion_level(survey, {x, y - 1})
  end

  defp erosion_level(%Survey{erosion_cache: cache}, coord) do
    Map.get(cache, coord)
  end

  defp initialize(depth, {x_target, y_target}) do
    %Survey{depth: depth, x_target: x_target, y_target: y_target, x_max: x_target + 25, y_max: y_target + 25}
  end

  defp risk_total(%Survey{risks: risks}) do
    Enum.sum(risks)
  end
end
