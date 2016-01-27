# so we want to take in a message and yield what?
# yield the parts of the message that have been translated to the various parts?
# in python we'd translate it to the dictionary in the serializer, everything else can do what it wants


defmodule Glossolalia.Hl7Messaging.MllpSerializer do

  @moduledoc false
  require HL7.Composite
  require Logger
  @behaviour Phoenix.Transports.Serializer
  alias Phoenix.Socket.Reply
  alias Phoenix.Socket.Message
  alias Phoenix.Socket.Broadcast

  def fastlane!(%Broadcast{} = msg) do
    %Message{topic: msg.topic,
             event: msg.event,
             payload: msg.payload}
  end
  #
  # def encode!(result) do
  #   HL7.write(result, output_format: :text, trim: true)
  # end

  def encode!(%Reply{} = reply) do
    %Message{
      topic: reply.topic,
      event: "phx_reply",
      ref: reply.ref,
      payload: %{status: reply.status, response: reply.payload}
    }
  end

  def encode!(%Message{} = msg), do: msg

  def clean(msg) do
    if String.starts_with? msg, "\v" do
      Logger.debug "cleaning vertical tab"
      msg = String.lstrip(msg, ?\v)
    end
    if String.ends_with? msg, "\x1c\r" do
      Logger.debug "string ends with File Seperator, cleaning..."
      msg = String.slice(msg, 0, String.length(msg) - 2)
    end

    unless String.ends_with? msg, "\r" do
      Logger.debug "string does not end with carriage return, adding..."
      msg = msg <> "\r"
    end

    msg
  end

  @doc """
  Decodes JSON String into `Phoenix.Socket.Message` struct.
  """
  def decode!(message) do
    case HL7.read(clean(message), input_format: :wire) do
      {:ok, req} ->
        req
      {:error, err} ->
        Logger.error err
        ""
    end
  end
end
