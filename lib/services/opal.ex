defmodule Glossolalia.Services.OPAL do
  use Glossolalia.Services
  
  defstruct url: 'http://localhost:8000', name: 'Just another OPAL Instance'
  
  @encoding Glossolalia.Encodings.OPAL
  
  @doc"""
  Return a patient's details
  """
  def read(instance, :patient, id) do
    get_json "#{instance[:url]}/api/v0.1/patient/#{id}"
  end

  @doc"""
  Return an episode's details
  """
  def read(instance, :episode, id) do
    get_json "#{instance[:url]}/api/v0.1/episode/#{id}"
  end

  
  @doc"""
  Accept POSTed data for various types of event
  """
  def accept(:change, data) do
    {:ok, @encoding.decode data}
  end
  
  # Accept POST 

  # Subscribe

  @doc """
  POST episode data for a change to an episode

  Change data involves a pre and a post state.
  Writing to OPAL requires just the POST state to be sent.
  """
  def write(instance, :change, data) do
    post_json "#{instance[:url]}/api/v0.1/episode/#{data["post"]["id"]}/change", data["post"]
    {:ok, "Posted"}
  end
  
  # Publish

end
