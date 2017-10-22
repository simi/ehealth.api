defmodule Il.Web.UserRoleController do
  @moduledoc false

  use Il.Web, :controller

  alias Il.API.Mithril, as: MithrilAPI

  action_fallback Il.Web.FallbackController

  def index(%Plug.Conn{req_headers: headers} = conn, params) do
    with {:ok, %{"data" => roles}} = MithrilAPI.get_user_roles(get_consumer_id(headers), params) do
      render(conn, "index.json", roles: roles)
    end
  end
end
