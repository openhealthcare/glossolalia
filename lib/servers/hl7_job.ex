defmodule Glossolalia.Servers.HL7Job do
  require Logger
  alias  Glossolalia.Encodings.HL7
  require  Glossolalia.Encodings.HL7

  def handle_request(sender, socket, request) do
    header_line = String.rstrip(request)
    msg = :ehl7.decode request

    try do
      fields = :ehl7.segment(:msh, msg)

      mt = HL7.message_header(fields, :message_type)
      te = HL7.message_header(fields, :trigger_event)

      process_message(mt, te, sender, header_line, fields, socket)
    rescue
      # Process an error. Ideally have the server responder
      # process timeout and send an AE instead.
      e ->
        Logger.error(e)
        send sender,{:ok, "Sending AE message"}
    end
  end

  defp get_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  def process_message("ADT", "A01", sender, header_line, msg, socket) do
    # Read the next 5 lines of the message
    lines = for n <- 1..4, do: get_line(socket)

    full_message = [header_line | lines]
    # TODO: Store full_message somewhere

    msg_id = HL7.message_header(msg, :message_control_id)
    response = "#{header_line}\nMSA|AA|#{msg_id}\r"
    send sender,{:ok, response}
  end


  def process_message(_, _, sender, line, _) do
    Logger.error("Don't understand #{line}")
    response = "EA Message"
    send sender,{:ok, response}
  end

end