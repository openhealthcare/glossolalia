# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Glossolalia.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_glossolalia_key",
  session_secret: "H4(3EM*^TV#XLEW9M%W@S1T@8GIJ%8!&8U1(%19%SW1%0UI1P(0=&^_$$S3H&5@L4ZO",
  catch_errors: true,
  debug_errors: false,
  error_controller: Glossolalia.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
