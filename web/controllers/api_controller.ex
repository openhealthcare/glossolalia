defmodule Glossolalia.APIController do
  use Phoenix.Controller

  def accept(conn, %{"servicetype" => "OPAL", "event" => event, "name" => name, "data" => data}) do
    Phoenix.Topic.broadcast "accept", {:OPAL, String.to_atom(event), name, data}
    json conn, JSON.encode!(%{:success => "We got your #{event} safely. Thanks."})
  end
  
end

