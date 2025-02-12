defmodule Dapp.Data.Repo.InviteRepoTest do
  use ExUnit.Case
  alias Ecto.Adapters.SQL.Sandbox

  # Repo being tested
  alias Dapp.Data.Repo.InviteRepo

  # Setup test context
  setup do
    :ok = Sandbox.checkout(Dapp.Repo)
    {:ok, user, role} = UserUtil.persist_user()
    email = FakeData.generate_email_addresss()

    %{
      params: %{
        email: email,
        user_id: user.id,
        role_id: role.id
      },
      expect: %{
        user_id: user.id,
        role_id: role.id,
        email: email
      }
    }
  end

  # Test signup repo
  describe "InviteRepo" do
    test "should enable user signups via invite", ctx do
      # Test invite creation step
      assert {:ok, created} = InviteRepo.create(ctx.params)
      assert created.user_id == ctx.expect.user_id
      assert created.role_id == ctx.expect.role_id
      assert created.email == ctx.expect.email

      # Test lookup step
      assert {:ok, invite} = InviteRepo.lookup(created.id, created.email)
      assert invite.id == created.id
      assert invite.email == created.email

      # Test user signup step
      blockchain_address = FakeData.generate_blockchain_address()
      user_params = %{blockchain_address: blockchain_address, email: ctx.params.email}
      assert {:ok, user} = InviteRepo.signup(user_params, invite)
      assert user.role_id == invite.role_id
      assert user.email == invite.email

      # Ensure invite has been consumed
      assert {:error, error} = InviteRepo.lookup(created.id, ctx.params.email)
      assert error.message == "invite does not exist or has already been consumed"
    end

    test "should fail to create an invite given empty params" do
      assert {:error, error} = InviteRepo.create(%{})
      assert error.message == "failed to create invite"
    end

    test "should fail looking up an invite that does not exist" do
      assert {:error, error} = InviteRepo.lookup(Nanoid.generate(), FakeData.generate_email_addresss())
      assert error.message == "invite does not exist or has already been consumed"
    end

    test "should fail signup given empty params", ctx do
      assert {:ok, invite} = InviteRepo.create(ctx.params)
      assert {:error, error} = InviteRepo.signup(%{}, invite)
      assert error.message == "signup failure"
    end
  end
end
