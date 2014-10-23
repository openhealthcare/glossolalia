defmodule Glossolalia.APIController do
  use Phoenix.Controller

  def accept(conn, %{"servicetype" => "OPAL", "event" => event, "name" => name, "data" => data}) do
    IO.puts "DATA WAS: #{inspect data}"
    Phoenix.Topic.broadcast "accept", {:OPAL, String.to_atom(event), String.to_atom(name), data}
    json conn, JSON.encode!(%{:success => "We got your #{event} safely. Thanks."})
  end
  
end

