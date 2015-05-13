defmodule Glossolalia.Servers.HL7Job do

  def handle_request(sender, request) do
    IO.inspect request
    lines = String.split(request, "\r")
    IO.inspect lines

    # Store the data, process the MSH message
    # to find the ID, return an MSH/ACK with AA.
    response = "OK"

    send sender,{:ok, response}
  end



end