defmodule Advent2018.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_2018,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libgraph, git: "https://github.com/bitwalker/libgraph", branch: "main"}
    ]
  end
end
