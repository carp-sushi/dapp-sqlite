defmodule Dapp.UseCase.User.ListUsers do
  @moduledoc """
  List recently created users
  """
  use Dapp.Data.Keeper
  use Dapp.UseCase

  alias Dapp.Dto

  @impl true
  def execute(_args) do
    users = Enum.map(user_repo().list_recent(), &Dto.from_schema/1)
    success(%{users: users})
  end
end
