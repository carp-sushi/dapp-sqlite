defmodule Dapp.Repo do
  @moduledoc """
  Sqlite database repository.
  """
  use Ecto.Repo,
    otp_app: :dapp,
    adapter: Ecto.Adapters.SQLite3
end
