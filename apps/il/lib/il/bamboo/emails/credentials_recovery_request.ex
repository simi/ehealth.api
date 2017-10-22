defmodule Il.Bamboo.Emails.CredentialsRecoveryRequest do
  @moduledoc false
  alias Il.Bamboo.Emails.Sender

  def send(to, body),
    do: Sender.send_email(to, body, config()[:from], config()[:subject])

  defp config, do: Confex.fetch_env!(:il, __MODULE__)
end
