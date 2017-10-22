use Mix.Config

# Configuration for test environment
config :ex_unit, capture_log: true


# We don't run a server during test. If one is required,
# you can enable the server option below.
config :il, Il.Web.Endpoint,
  http: [port: 4001],
  server: true

# Configures PRM API
config :il, Il.API.PRM,
  endpoint: {:system, "PRM_ENDPOINT", "http://localhost:4040"}

# Configures Man API
config :il, Il.API.Man,
  endpoint: {:system, "MAN_ENDPOINT", "http://localhost:4040"}

# Configures OPS API
config :il, Il.API.OPS,
  endpoint: {:system, "OPS_ENDPOINT", "http://localhost:4040"}

# Configures UAdress API
config :il, Il.API.UAddress,
  endpoint: {:system, "UADDRESS_ENDPOINT", "http://localhost:4040"}

config :il, Il.API.Mithril,
  endpoint: {:system, "OAUTH_ENDPOINT", "http://localhost:4040"}

config :il, Il.API.OTPVerification,
  endpoint: {:system, "OTP_VERIFICATION_ENDPOINT", "http://localhost:4040"}

config :il, Il.API.MPI,
  endpoint: {:system, "MPI_ENDPOINT", "http://localhost:4040"}

config :il, Il.API.Gandalf,
  endpoint: {:system, "GNDF_ENDPOINT", "http://localhost:4040"}

config :il, Il.API.Signature,
  enabled: {:system, :boolean, "DIGITAL_SIGNATURE_ENABLED", false}

config :il, mock: [
  port: {:system, :integer, "TEST_MOCK_PORT", 4040},
  host: {:system, "TEST_MOCK_HOST", "localhost"}
]

# Configures Legal Entities token permission
config :il, Il.Plugs.ClientContext,
  tokens_types_personal: {:system, :list, "TOKENS_TYPES_PERSONAL", ["MSP"]},
  tokens_types_mis: {:system, :list, "TOKENS_TYPES_MIS", ["MIS"]},
  tokens_types_admin: {:system, :list, "TOKENS_TYPES_ADMIN", ["NHS ADMIN"]}

config :il, :legal_entity_employee_types,
  msp: {:system, "LEGAL_ENTITY_MSP_EMPLOYEE_TYPES", ["OWNER", "HR", "DOCTOR", "ADMIN", "ACCOUNTANT"]},
  pharmacy: {:system, "LEGAL_ENTITY_PHARMACY_EMPLOYEE_TYPES", ["PHARMACY_OWNER", "PHARMACIST"]}

config :il, Il.API.MediaStorage,
  endpoint: {:system, "MEDIA_STORAGE_ENDPOINT", "http://localhost:4040"},
  legal_entity_bucket: {:system, "MEDIA_STORAGE_LEGAL_ENTITY_BUCKET", "legal-entities-dev"},
  declaration_request_bucket: {:system, "MEDIA_STORAGE_DECLARATION_REQUEST_BUCKET", "declaration-requests-dev"},
  declaration_bucket: {:system, "MEDIA_STORAGE_DECLARATION_BUCKET", "declarations-dev"},
  medication_request_request_bucket:
    {:system, "MEDIA_STORAGE_MEDICATION_REQUEST_REQUEST_BUCKET", "medication-request-requests-dev"},
  enabled?: {:system, :boolean, "MEDIA_STORAGE_ENABLED", false}

# Configures Gandalf API
config :il, Il.API.Gandalf,
  endpoint: {:system, "GNDF_ENDPOINT", "https://api.gndf.io"},
  client_id: {:system, "GNDF_CLIENT_ID", "some_client_id"},
  client_secret: {:system, "GNDF_CLIENT_SECRET", "some_client_secret"},
  application_id: {:system, "GNDF_APPLICATION_ID", "some_gndf_application_id"},
  table_id: {:system, "GNDF_TABLE_ID", "some_gndf_table_id"}

# employee request invitation
# Configures employee request invitation template
config :il, Il.Man.Templates.EmployeeRequestInvitation,
  id: {:system, "EMPLOYEE_REQUEST_INVITATION_TEMPLATE_ID", 1}

# employee created notification
# Configures employee created notification template
config :il, Il.Man.Templates.EmployeeCreatedNotification,
  id: {:system, "EMPLOYEE_CREATED_NOTIFICATION_TEMPLATE_ID", 35}

config :il, Il.Man.Templates.DeclarationRequestPrintoutForm,
  id: {:system, "DECLARATION_REQUEST_PRINTOUT_FORM_TEMPLATE_ID", 4}

config :il, Il.Man.Templates.CredentialsRecoveryRequest,
  id: {:system, "CREDENTIALS_RECOVERY_REQUEST_INVITATION_TEMPLATE_ID", 5}

config :il, Il.Bamboo.Emails.HashChainVeriricationNotification,
  from: "automatic@system.com",
  to: "serious@authority.com",
  subject: "Hash chain has been mangled!"

config :il, Il.Man.Templates.HashChainVerificationNotification,
  id: 32167,
  format: "text/html",
  locale: "uk_UA"

# Configures declaration request terminator
config :il, Il.DeclarationRequest.Terminator,
  frequency: 100,
  utc_interval: {0, 23}

# Configures employee request terminator
config :il, Il.EmployeeRequest.Terminator,
  frequency: 100,
  utc_interval: {0, 23}

config :il, Il.Bamboo.Mailer,
  adapter: Bamboo.TestAdapter

config :il,
  sql_sandbox: true, # Run acceptance test in concurrent mode
  run_declaration_request_terminator: false # Don't start terminator in test env

# Configure your database
config :il, Il.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ehealth_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 120_000_000

config :il, Il.PRMRepo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "prm_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  types: Il.PRM.PostgresTypes,
  ownership_timeout: 120_000_000
