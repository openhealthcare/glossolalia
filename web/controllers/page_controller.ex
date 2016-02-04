defmodule Glossolalia.PageController do
  use Glossolalia.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
