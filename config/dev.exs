use Mix.Config

config :glossolalia, Glossolalia.Endpoint,
  http: [port: System.get_env("PORT") || 5000],
  debug_errors: true,
  cache_static_lookup: false

# Enables code reloading for development
config :glossolalia, Glossolalia.Endpoint, 
 code_reloader: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
