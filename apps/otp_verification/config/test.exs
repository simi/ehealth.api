use Mix.Config

# Configuration for test environment
config :ex_unit, capture_log: true


# Configure your database
config :otp_verification, OtpVerification.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: {:system, "DB_NAME", "otp_verification_api_test"},
  ownership_timeout: 120_000_000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :otp_verification, OtpVerification.Web.Endpoint,
  http: [port: 4005],
  server: true

# Print only warnings and errors during test
config :logger, level: :debug

# Run acceptance test in concurrent mode
config :otp_verification, sql_sandbox: true

config :otp_verification, :mouth,
  adapter: Mouth.TestAdapter
