defmodule Il.Web.HashChainView do
  @moduledoc false

  use Il.Web, :view

  def render("notification_sent.json", _) do
    %{
      message: "The notification was successfully sent."
    }
  end
end
