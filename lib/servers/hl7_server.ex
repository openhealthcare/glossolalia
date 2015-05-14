defmodule Glossolalia.Servers.HL7 do
  alias Glossolalia.Servers.HL7Job
  require Logger

  @doc """
  Sets up the socket and then after setting up the listen queue,
  waits to accept connections
  """
  def listen(port) do
    IO.puts "Listening on port #{port}"
    options = [:binary, {:packet, :line}, {:active, false}, {:reuseaddr, true}]
    {:ok, listen_socket} = :gen_tcp.listen(port, options)
    accept(listen_socket)
  end

  @doc """
  Accepts a connection on the socket, spawns a job to
  handle it, and then TCO fun.
  """
  def accept(listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    spawn(fn() -> do_server(socket) end)
    accept(listen_socket)
  end

  @doc """
  Handles a single request by spawning a process to wait for the
  results, and then spawning a process to handle the data.  When
  the job has data to return it will send it to the new responder
  process before waiting on more data.  When the client closes the
  connection, we're all done.
  """
  def do_server(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        responder = spawn(fn() -> do_respond(socket) end)
        spawn(HL7Job, :handle_request, [responder, socket, to_string(data)])
      {:error, :closed} -> :ok
    end
  end

  """
  This process will block until it is given a response to send
  back to the caller.
  """
  defp do_respond(socket) do
    receive do
      {:ok, response} ->
        :gen_tcp.send(socket, "#{response}\n")
        :gen_tcp.close(socket)
        #Logger.info(response)
    after
      500 ->
        :gen_tcp.send(socket, "EA\n")
        :gen_tcp.close(socket)
    end
  end
end

