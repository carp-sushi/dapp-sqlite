defmodule RoleUtil do
  @moduledoc false
  import Hammox

  alias Dapp.Data.Schema.Role
  alias Dapp.Repo

  @doc "Setup mock for listing all roles"
  def mock_list_roles(size), do: expect(MockRoleRepo, :all, fn -> FakeData.generate_roles(size) end)

  @doc "Ensure a role by exists in the test database."
  def persist_role(name) do
    case Repo.get_by(Role, name: name) do
      nil -> Repo.insert!(%Role{name: name})
      role -> role
    end
  end
end
