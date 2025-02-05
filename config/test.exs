import Config

# The MIX_TEST_PARTITION environment variable can be used to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dapp, Dapp.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "tmp/data/test#{System.get_env("MIX_TEST_PARTITION")}.db",
  default_transaction_mode: :immediate

# Print warnings and errors running tests
config :logger, level: :warning
