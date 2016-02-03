defmodule Glossolalia.Endpoint do
  use Phoenix.Endpoint, otp_app: :glossolalia
  use Application
  require Logger


  socket "/socket", Glossolalia.UserSocket
  # root_url = Application.get_env(:glossolalia, Glossolalia.Endpoint)[:root_url]
  root_url = "/"

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: root_url, from: :glossolalia, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_glossolalia_key",
    signing_salt: "tdTgxEv6"

  plug Glossolalia.Router
end
