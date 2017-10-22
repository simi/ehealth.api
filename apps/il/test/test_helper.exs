{:ok, _} = Plug.Adapters.Cowboy.http Il.MockServer, [], port: Confex.fetch_env!(:il, :mock)[:port]
{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Il.Repo, :manual)
