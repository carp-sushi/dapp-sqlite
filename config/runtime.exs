import Config

# When running in prod, read database path and pool size from environment variables.
if config_env() == :prod do
  db_path = System.get_env("DB_PATH") || raise "DB_PATH not defined"
  db_pool_size = System.get_env("DB_POOL_SIZE") || "10"

  # Verify network prefix has been set correctly
  if System.get_env("NETWORK_PREFIX") not in ["tp", "pb"] do
    raise ~s(NETWORK_PREFIX must be set to "tp" or "pb")
  end

  config :dapp, Dapp.Repo,
    database: db_path,
    pool_size: String.to_integer(db_pool_size),
    default_transaction_mode: :immediate,
    busy_timeout: 5000
end
