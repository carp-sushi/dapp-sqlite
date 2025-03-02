defmodule Dapp.Data.Repo.RoleRepoTest do
  use ExUnit.Case

  alias Dapp.Data.Repo.RoleRepo
  alias Ecto.Adapters.SQL.Sandbox

  # Set up SQL sandbox and insert a random number of roles.
  setup do
    :ok = Sandbox.checkout(Dapp.Repo)

    roles =
      5 |> :rand.uniform() |> FakeData.generate_roles() |> Enum.map(fn role -> RoleUtil.persist_role(role.name) end)

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
