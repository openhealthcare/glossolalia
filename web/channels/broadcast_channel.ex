defmodule Glossolalia.BroadcastChannel do
  use Phoenix.Channel

  def join("broadcast:" <> _app_name, auth_msg, socket) do
    {:ok, socket}
  end

  def handle_in("change", payload, socket) do
    IO.puts "Handling an incoming change"
    broadcast! socket, "change", payload
    {:noreply, socket}
  end

  def handle_out("change", payload, socket) do
    IO.puts "Handling an outgoing change"
    push socket, "change", payload
    {:noreply, socket}
  end

end
