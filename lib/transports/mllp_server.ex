alias Glossolalia.Transports.Hl7.Processor


defmodule Glossolalia.Transports.Mllp.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(Phoenix.Transports.Mllp.Server, [], restart: :temporary)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end


defmodule Glossolalia.Transports.Mllp.Server do
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
    GenServer.start_link(__MODULE__, @initial_state)
  end

  def init do
    opts = [:binary, active: false]
    Logger.error "it begins"

    case :gen_tcp.listen(8000, opts) do
      {:ok, socket} -> loop_acceptor(socket)
      {:error, issue} ->
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
        Logger.error issue
    end
  end

  def handle_response(client) do
    case :gen_tcp.recv(client, 0) do
      {:ok, data} ->
        Logger.debug "success handle_response"
        Logger.debug data
        :gen_tcp.send(client, Processor.process_message(data))
        handle_response(client)
      {:error, issue} ->
        Logger.error issue
    end
  end
end
