use Mix.Config

config :phoenix, Glossolalia.Router,
  port: System.get_env("PORT") || 5000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_glossolalia_key",
  session_secret: "H4(3EM*^TV#XLEW9M%W@S1T@8GIJ%8!&8U1(%19%SW1%0UI1P(0=&^_$$S3H&5@L4ZO",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


