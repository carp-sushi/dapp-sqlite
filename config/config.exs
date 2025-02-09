import Config

# Base compile time repo config
config :dapp,
  ecto_repos: [Dapp.Repo]

# Base compile time dapp config
config :dapp,
  uri_base: "/dapp/api/v1",
  http_port: 8080,
  auth_header: "x-account-address",
  max_records: 100

# Configure nanoid size, alphabet.
config :nanoid,
  size: 21,
  alphabet: "23456789abcdefghijkmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ"

# Load environment specific configuration.
import_config "#{config_env()}.exs"
