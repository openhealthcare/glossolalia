defmodule Glossolalia.Router do
  use Glossolalia.Web, :router

  alias Glossolalia.PatientController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    resources "/patient", PatientController, except: [:new, :edit]
    plug :accepts, ["json"]
  end

  scope "/", Glossolalia do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Glossolalia do
  #   pipe_through :api
  # end
end
