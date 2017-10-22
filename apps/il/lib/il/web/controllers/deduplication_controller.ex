defmodule Il.Web.DeduplicationsController do
  @moduledoc false

  use Il.Web, :controller

  alias Il.DuplicatePersons.Signals

  action_fallback Il.Web.FallbackController

  def found_duplicates(conn, _params) do
    Signals.deactivate()

    text conn, "OK"
  end
end
