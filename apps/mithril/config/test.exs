use Mix.Config

# Configuration for test environment
config :ex_unit, capture_log: true

# Configure your database
config :mithril, Mithril.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: {:system, "DB_NAME", "mithril_api_test"}

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mithril, Mithril.Web.Endpoint,
  http: [port: 4003],
  server: true

# Print only warnings and errors during test
config :logger, level: :debug

config :comeonin, :bcrypt_log_rounds, 1

# Run acceptance test in concurrent mode
config :mithril, sql_sandbox: true
config :bcrypt_elixir, :log_rounds, 4
