defmodule FakeData do
  @moduledoc """
  Test helper functions for generating fake data.
  """
  alias Dapp.Data.Schema.Invite
  alias Dapp.Data.Schema.Role
  alias Dapp.Data.Schema.User

  @doc "Generate a fake blockchain address."
  def generate_blockchain_address, do: String.downcase("tp#{Nanoid.generate(39)}")

  @doc "Generate a fake email address"
  def generate_email_addresss, do: "email#{Nanoid.generate()}@fakedata.com"

  @doc "Generate a fake name"
  def generate_name, do: "name#{Nanoid.generate()}"

  @doc "Generate a fake role"
  def generate_role, do: %Role{id: :rand.uniform(1000), name: generate_name()}

  @doc "Generate a sequence of fake roles"
  def generate_roles(size), do: (&generate_role/0) |> Stream.repeatedly() |> Enum.take(size)

  @doc "Generate a fake user"
  def generate_user(role_id \\ nil),
    do: %User{
      id: Nanoid.generate(),
      blockchain_address: generate_blockchain_address(),
      name: generate_name(),
      email: generate_email_addresss(),
      role_id: role_id || generate_role().id
    }

  @doc "Generate a sequence of fake users"
  def generate_users(size), do: (&generate_user/0) |> Stream.repeatedly() |> Enum.take(size)

  @doc "Generate a fake invite"
  def generate_invite(user_id \\ nil),
    do: %Invite{
      id: Nanoid.generate(),
      email: generate_email_addresss(),
      role_id: generate_role().id,
      user_id: user_id || Nanoid.generate()
    }
end
