defmodule Il.Web.UserRoleView do
  @moduledoc false

  use Il.Web, :view

  def render("index.json", %{roles: roles}) do
    render_many(roles, __MODULE__, "role.json")
  end

  def render("role.json", %{user_role: role}), do: role
end
