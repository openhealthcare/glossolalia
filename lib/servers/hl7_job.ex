defmodule Glossolalia.Servers.HL7Job do
  require Logger
  alias  Glossolalia.Encodings.HL7
  require  Glossolalia.Encodings.HL7

  def handle_request(sender, request) do
    lines = String.split(request, "\n")
    header_line = List.first(lines)
    msg = :ehl7.decode header_line

    try do
      res = :ehl7.segment(:msh, msg)
      process_msh(sender, res, header_line)
    rescue
      # Process an error. Ideally have the server responder
      # process timeout and send an AE instead.
      e ->
        send sender,{:ok, "Sending AE message"}
        Logger.error(e)
    end
  end

  def process_msh(sender, msg, header_line) do
    msg_id = HL7.message_header(msg, :message_control_id)

    response = "#{header_line}\nMSA|AA|#{msg_id}\r"
    Logger.info(response)
    send sender,{:ok, response}
  end

end