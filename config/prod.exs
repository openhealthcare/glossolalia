use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Glossolalia.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_glossolalia_key",
  session_secret: "H4(3EM*^TV#XLEW9M%W@S1T@8GIJ%8!&8U1(%19%SW1%0UI1P(0=&^_$$S3H&5@L4ZO"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

