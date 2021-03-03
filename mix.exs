defmodule PracticePlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :practice_movies,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {App, []},
      env: [cowboy_port: 8085]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"},
      {:poison, "~> 4.0"},
    ]
  end
end
