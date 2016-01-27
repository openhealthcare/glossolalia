use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :glossolalia, Glossolalia.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
# config :glossolalia, Glossolalia.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "glossolalia_test",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox

  config :glossolalia, Glossolalia.Repo,
    otp_app: "glossolalia",
    adapter: Sqlite.Ecto,
    database: "glossolalia.sqlite3",
    pool: Ecto.Adapters.SQL.Sandbox
