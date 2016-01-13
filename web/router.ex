defmodule Glossolalia.Router do
  use Phoenix.Router

  # socket "/ws", Glossolalia do
  #   channel "broadcast:*", BroadcastChannel
  # end



  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Glossolalia do
    pipe_through :browser

    get "/", PageController, :index, as: :pages
  end

  scope "/api", Glossolalia do
    pipe_through :api

    post "/v0.1/accept", APIController, :accept
  end
end
