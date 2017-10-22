defmodule Il.Man.Templates.HashChainVerificationNotification do
  @moduledoc false

  use Confex, otp_app: :il
  alias Il.API.Man

  def render(failure_details) do
    Man.render_template(config()[:id], %{
      format: config()[:format],
      locale: config()[:locale],
      failure_details: failure_details
    })
  end
end
