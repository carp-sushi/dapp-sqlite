defmodule Dapp.Data.Repo.UserRepoTest do
  use ExUnit.Case
  alias Ecto.Adapters.SQL.Sandbox

  # Repo being tested
  alias Dapp.Data.Repo.UserRepo

  # Test context
  setup do
    # When using a sandbox, each test runs in an isolated, independent transaction
    # which is rolled back after test execution.
    :ok = Sandbox.checkout(Dapp.Repo)
    assert {:ok, user, _role} = UserUtil.persist_user()
    %{address: user.blockchain_address, expect: %{user: user}}
  end

  # Test user repo
  describe "UserRepo" do
    test "should get a user by blockchain address", ctx do
      assert UserRepo.get_by_address(ctx.address).id == ctx.expect.user.id
    end

    test "should get recent users", ctx do
      assert [ctx.expect.user] == UserRepo.list_recent()
    end

    test "should handle nil blockchain address on get" do
      assert is_nil(UserRepo.get_by_address(nil))
    end

    test "should fail to create user given empty params" do
      assert {:error, error} = UserRepo.create(%{})
      assert error.message == "failed to create user"
    end
  end
end
