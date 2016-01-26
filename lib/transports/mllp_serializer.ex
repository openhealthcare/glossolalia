# so we want to take in a message and yield what?
# yield the parts of the message that have been translated to the various parts?
# in python we'd translate it to the dictionary in the serializer, everything else can do what it wants


defmodule Glossolalia.Transports.Mllp.Serializer do
  @moduledoc false
  require HL7.Composite
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

  @doc """
  Decodes JSON String into `Phoenix.Socket.Message` struct.
  """
  def decode!(message) do
    {:ok, req} = HL7.read(message, input_format: :wire)
    req
  end
end
