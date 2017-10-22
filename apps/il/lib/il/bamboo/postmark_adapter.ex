defmodule Il.Bamboo.PostmarkAdapter do
  @moduledoc false
  @behaviour Bamboo.Adapter
  alias Bamboo.PostmarkAdapter

  def deliver(email, config),
    do: PostmarkAdapter.deliver(email, config)

  def handle_config(_config) do
    :il
    |> Confex.fetch_env!(Il.Bamboo.Mailer)
    |> Enum.into(%{})
    |> PostmarkAdapter.handle_config()
  end
end
