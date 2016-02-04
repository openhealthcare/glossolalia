alias Glossolalia.Hl7Messaging.Hl7Processor


defmodule Glossolalia.Hl7Messaging.MllpServer do
  @moduledoc false
  require Logger

  use GenServer
  require HL7.Composite

  # alias Phoenix.PubSub
  # alias Phoenix.Socket.Transport
  # alias Phoenix.Socket.Broadcast
  # alias Phoenix.Socket.Message

  @initial_state %{socket: nil}

  def start_link do
    # GenServer.start_link(__MODULE__, @initial_state)
  end

  def init do
    opts = [:binary, active: false, reuseaddr: true]
    Logger.error "it begins"

    case :gen_tcp.listen(4500, opts) do
      {:ok, socket} -> loop_acceptor(socket)
      {:error, issue} ->
        Logger.error "int handle_response"
        Logger.error issue
    end
  end

  def command(pid, cmd) do
    GenServer.call(pid, {:command, cmd})
  end

  def loop_acceptor(socket) do
    case :gen_tcp.accept(socket) do
      {:ok, client} ->
        Logger.debug "success loop_acceptor"
        handle_response(client)
        loop_acceptor(socket)
      {:error, issue} ->
        Logger.error "failed loop_acceptor"
        Logger.error issue
    end
  end

  def handle_response(client) do
    case :gen_tcp.recv(client, 0) do
      {:ok, data} ->
        Logger.debug "success handle_response"
        Logger.debug data
        result = :gen_tcp.send(client, Hl7Processor.process_message(data))
        Logger.error ("result sent")
        Logger.error result
        handle_response(client)
      {:error, issue} ->
        Logger.error "failed handle_response"
        Logger.error issue
    end
  end
end
