defmodule Glossolalia.Services.OPAL do
  use Glossolalia.Services
  
  defstruct url: 'http://localhost:8000', name: 'Just another OPAL Instance'
  
  @encoding Glossolalia.Encodings.OPAL
  
  @doc"""
  Return a patient's details
  """
  def read(instance, :patient, id) do
    @encoding.decode(get_json "#{instance[:url]}/api/v0.1/patient/#{id}")
  end

  @doc"""
  Return an episode's details
  """
  def read(instance, :episode, id) do
    @encoding.decode(get_json "#{instance[:url]}/api/v0.1/episode/#{id}")
  end

  @doc"""
  Accept POSTed data for various types of event
  """
  def accept(:change, data) do
    {:ok, @encoding.decode data}
  end
  
  @doc """
  POST episode data for an admitted patient
  """
  def write(instance, :admit, data) do
    IO.puts "Writing an admission to OPAL service #{inspect instance}"
    post_json "#{instance[:url]}/api/v0.1/episode/admit", @encoding.encode(data)
    {:ok, "Posted"}
  end

  @doc """
  POST episode data for a discharged patient
  """
  def write(instance, :discharge, data) do
    post_json "#{instance[:url]}/api/v0.1/episode/#{data["id"]}/discharge", @encoding.encode(data)
    {:ok, "Posted"}
  end

  @doc """
  POST episode data for a change to an episode

  Change data involves a pre and a post state.
  Writing to OPAL requires just the POST state to be sent.
  """
  def write(instance, :change, data) do
    post_json "#{instance[:url]}/api/v0.1/episode/#{data["post"]["id"]}/change", @encoding.encode(data["post"])
    {:ok, "Posted"}
  end
  
end
