defmodule Il.Web.UaddressesController do
  @moduledoc false
  use Il.Web, :controller
  alias Il.Divisions.UAddress

  action_fallback Il.Web.FallbackController

  def update_settlements(conn, %{"id" => _id, "settlement" => _settlement} = attrs) do
    with {:ok, %{settlement: %{"meta" => %{}} = response}} <- UAddress.update_settlement(attrs, conn.req_headers) do
      proxy(conn, response)
    end
  end
end
