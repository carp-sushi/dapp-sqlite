defmodule Dapp.Data.Repo.RoleRepoTest do
  use ExUnit.Case
  alias Ecto.Adapters.SQL.Sandbox

  # Repo being tested
  alias Dapp.Data.Repo.RoleRepo

  # Set up SQL sandbox and insert a random number of roles.
  setup do
    :ok = Sandbox.checkout(Dapp.Repo)
    roles = FakeData.generate_roles(:rand.uniform(5)) |> Enum.map(fn role -> RoleUtil.persist_role(role.name) end)
    %{expect: %{size: length(roles)}}
  end

  # Test that repo can query roles from the db.
  describe "RoleRepo" do
    test "should return all stored roles", ctx do
      roles = RoleRepo.all()
      assert length(roles) == ctx.expect.size
    end
  end
end
