defmodule Il.Web.HashChainController do
  @moduledoc false

  alias IL.HashChain.Verification

  use Il.Web, :controller

  action_fallback Il.Web.FallbackController

  def verification_failed(conn, params) do
    Verification.send_failure_notification(params)

    conn
    |> put_status(200)
    |> render("notification_sent.json")
  end
end
