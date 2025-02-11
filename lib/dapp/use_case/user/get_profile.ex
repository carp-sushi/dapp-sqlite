defmodule Dapp.UseCase.User.GetProfile do
  @moduledoc """
  Show the authorized user's profile.
  """
  alias Dapp.Dto
  use Dapp.UseCase

  @impl true
  def execute(args) do
    case Map.get(args, :user) do
      nil -> fail("missing required arg: user")
      user -> %{profile: Dto.from_schema(user)} |> success()
    end
  end
end
