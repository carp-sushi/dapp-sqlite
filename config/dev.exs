import Config

config :dapp, Dapp.Repo,
  database: "tmp/dapp_dev.db",
  default_transaction_mode: :immediate,
  busy_timeout: 5000,
  wal_auto_check_point: 0

config :dapp,
  http_port: 8081
