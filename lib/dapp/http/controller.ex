defmodule Dapp.Http.Controller do
  @moduledoc """
  HTTP request handler.
  """
  alias Dapp.Http.Presenter

  require Logger

  @doc "Execute a use case and send the result as json."
  def execute(conn, use_case, args \\ %{}) do
    args
    |> Map.merge(conn.assigns)
    |> tap(fn args -> Logger.debug("use case args = #{inspect(args)}") end)
    |> use_case.execute()
    |> Presenter.reply(conn)
  rescue
    e ->
      Logger.error(Exception.format(:error, e, __STACKTRACE__))
      Presenter.exception(conn)
  end
end
