defmodule Il.Web.UserView do
  @moduledoc false

  use Il.Web, :view

  def render("credentials_recovery_request.json", %{credentials_recovery_request: request}) do
    %{
      is_active: request.is_active,
      expires_at: request.expires_at
    }
  end

  def render("show.json", %{user: user}) do
    %{
      id: user["id"],
      email: user["email"],
      settings: user["settings"]
    }
  end
end
