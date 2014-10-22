defmodule Glossolalia.Accepter do
  def start_link do
    sub = spawn_link &(accept/0)
    Phoenix.Topic.subscribe(sub, "accept")
    {:ok, sub}
  end

  def accept do
    receive do
      {:OPAL, event, key, data} ->
        IO.puts "OPAL event"
      _ ->
    end
    accept
  end
                           
end
