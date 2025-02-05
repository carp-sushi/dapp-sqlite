import Config

config :dapp, Dapp.Repo,
  database: System.get_env("DB_PATH") || "tmp/data/dev.db",
  default_transaction_mode: :immediate

config :dapp,
  http_port: 8082
