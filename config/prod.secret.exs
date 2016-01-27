use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :glossolalia, Glossolalia.Endpoint,
  secret_key_base: "+Yi9A2nJAdlEGcnb+4IkAK/7wTKKPBOvHxOKetYExm3bUMkOMNUtXh08das3+9h/"

# Configure your database
# config :glossolalia, Glossolalia.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "glossolalia_prod",
#   pool_size: 20

config :glossolalia, Glossolalia.Repo,
  otp_app: "glossolalia",
  adapter: Sqlite.Ecto,
  database: "glossolalia.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox
