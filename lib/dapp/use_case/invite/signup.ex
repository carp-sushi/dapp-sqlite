defmodule Dapp.UseCase.Invite.Signup do
  @moduledoc """
  Add new users with valid invites.
  """
  alias Dapp.Dto
  use Dapp.Data.Keeper
  use Dapp.UseCase

  @impl true
  def execute(args) do
    case validate(args, [:invite_code, :email]) do
      :ok -> signup(args)
      error -> error
    end
  end

  # Lookup an invite using validated args and create a new user if found.
  defp signup(args) do
    case invite_repo().lookup(args.invite_code, args.email) do
      {:ok, invite} -> signup(args, invite)
      error -> error
    end
  end

  # Create a new user for an invite.
  defp signup(args, invite) do
    case invite_repo().signup(args, invite) do
      {:ok, user} -> %{profile: Dto.from_schema(user)} |> success()
      error -> error
    end
  end
end
