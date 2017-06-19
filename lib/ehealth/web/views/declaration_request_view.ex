defmodule EHealth.Web.DeclarationRequestView do
  @moduledoc false

  use EHealth.Web, :view
  alias EHealth.Web.DeclarationRequestView

  def render("show.json", %{declaration_request: declaration_request}) do
    render_one(declaration_request, DeclarationRequestView, "declaration_request.json")
  end

  def render("declaration_request.json", %{declaration_request: declaration_request}) do
    declaration_request
  end

  def render("microservice_error.json", %{"error" => _, "meta" => meta}) do
    %{
      message: "Error during microservice interaction. Accessing #{meta["url"]} resulted in #{meta["code"]}."
    }
  end

  def render("unprocessable_entity.json", %{error: error}) do
    error
  end
end