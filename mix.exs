defmodule Dapp.MixProject do
  use Mix.Project

  def project do
    [
      app: :dapp,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      preferred_cli_env: [quality: :test],
      test_coverage: [
        summary: [
          threshold: 80
        ],
        ignore_modules: [
          FakeData,
          InviteUtil,
          RoleUtil,
          UserUtil,
          Mix.Tasks.Migrate
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Dapp, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_commons, "~> 0.3.4"},
      {:ecto_identifier, "~> 0.2.0"},
      {:ecto_sqlite3, "~> 0.18"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.7.2"},
      {:hammox, "~> 0.7", only: :test},
      {:styler, "~> 1.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7.11", only: [:dev, :test], runtime: false}
    ]
  end

  # Helpful mix aliases
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      quality: ["test", "credo --strict"]
    ]
  end

  # Add fake data generators and mock helpers to path in test
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
