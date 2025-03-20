defmodule Dapp.Http.Request.CreateInviteRequest do
  @moduledoc """
  Validate requests to create invites.
  """
  import Ecto.Changeset
  import EctoCommons.EmailValidator

  alias Dapp.Error
  alias Ecto.Changeset

  @doc "Gather and validate use case args for creating an invite."
  def validate(conn) do
    data = %{}
    types = %{email: :string, role_id: :integer}
    keys = Map.keys(types)

    changeset =
      {data, types}
      |> Changeset.cast(conn.body_params, keys)
      |> validate_required(keys)
      |> validate_email(:email)
      |> validate_number(:role_id, greater_than: 0)

    if changeset.valid? do
      {:ok, Changeset.apply_changes(changeset)}
    else
      Error.new(changeset, "invalid invite request")
    end
  end
end
