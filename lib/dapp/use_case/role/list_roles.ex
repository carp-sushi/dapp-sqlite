defmodule Dapp.UseCase.Role.ListRoles do
  @moduledoc """
  List all available roles.
  """
  alias Dapp.Dto
  use Dapp.Data.Keeper
  use Dapp.UseCase

  @impl true
  def execute(_) do
    roles = role_repo().all() |> Enum.map(&Dto.from_schema/1)
    %{roles: roles} |> success()
  end
end
