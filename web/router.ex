defmodule Glossolalia.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end
  
  pipeline :api do
    plug :accepts, ~w(json)
  end
  
  # scope "/", Cedar do
  #   pipe_through :browser # Use the default browser stack
    
  #   get "/", PageController, :index, as: :pages
  #   get "/rules/", EditorController, :editor
  #   get "/api/v0.1/", Api01Controller, :index
  # end
  
  scope "/", Glossolalia do
    pipe_through :browser

    get "/", PageController, :index, as: :pages
  end 

  scope "/api", Glossolalia do
    pipe_through :api
    
    post "/v0.1/accept", APIController, :accept
  end
end
