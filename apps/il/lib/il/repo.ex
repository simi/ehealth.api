defmodule Il.Repo do
  @moduledoc false

  use Ecto.Repo, otp_app: :il
  use Scrivener, page_size: 50, max_page_size: 500
end
