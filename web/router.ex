defmodule Glossolalia.Router do
  use Phoenix.Router

  get "/", Glossolalia.PageController, :index, as: :pages
  post "/api/v0.1/accept/", Glossolalia.APIController, :accept

end
