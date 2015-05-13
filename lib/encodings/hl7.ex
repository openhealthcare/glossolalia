defmodule Glossolalia.Encodings.HL7 do
  require Record

  Record.defrecord :personal_info, Record.extract(:pid, from: "deps/ehl7/include/ehl7_segment.hrl")

  @doc """
  Takes HL7 data && decodes it.
  """
  def decode(data) do
    :erlang.ehl7.decode data
  end

  @doc """
  Encodes data for HL7
  """
  def encode(data) do
    :erlang.ehl7.encode data
  end

end
