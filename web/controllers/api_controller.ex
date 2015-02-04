defmodule Glossolalia.APIController do
  use Phoenix.Controller
  
  plug :action

  def accept(conn, %{"servicetype" => "OPAL", "event" => event, "name" => name, "data" => data}) do
    IO.puts "DATA WAS: #{inspect Poison.decode(data)}"
    {status, decoded} = Poison.decode(data)
    Phoenix.PubSub.broadcast "accept", {:OPAL, String.to_atom(event), String.to_atom(name), decoded}
    json conn, %{:success => "We got your #{event} safely. Thanks."}
  end
  
end

