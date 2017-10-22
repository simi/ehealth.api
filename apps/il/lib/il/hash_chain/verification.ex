defmodule IL.HashChain.Verification do
  @moduledoc false

  alias Il.Bamboo.Emails.HashChainVeriricationNotification, as: Email
  alias Il.Man.Templates.HashChainVerificationNotification, as: Template
  alias Il.Bamboo.Mailer

  def send_failure_notification(mangled_blocks) do
    {:ok, body} = Template.render(mangled_blocks)

    body
    |> Email.new
    |> Mailer.deliver_now
  end
end
