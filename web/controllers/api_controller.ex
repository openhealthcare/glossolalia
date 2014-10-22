defmodule Glossolalia.APIController do
  use Phoenix.Controller

  def accept(conn, %{"servicetype" => "OPAL", "event" => event, "key" => key, "data" => data}) do
    Phoenix.Topic.broadcast "accept", {:OPAL, event, key, data}
    json conn, JSON.encode!(%{:success => "We got your #{event} safely. Thanks."})
  end
  
end

