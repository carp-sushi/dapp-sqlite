import Config

config :dapp, Dapp.Repo,
  database: System.get_env("DB_PATH") || "tmp/data/dev.db",
  default_transaction_mode: :immediate,
  busy_timeout: 5000,
  wal_auto_check_point: 0

config :dapp,
  http_port: 8082
